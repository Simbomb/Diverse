import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class jdbc {
    public static void main(String[] args) throws SQLException {

            System.out.println("Enter Student_id:");
             Scanner myObj = new Scanner(System.in);  // Create a Scanner object
             String student_id = myObj.nextLine();  // Read user input
            boolean loop = true;
            while(loop) {
                System.out.println("Do you want to view list of available instruments(1), rent a new instrument(2) or cancel an ongoing rent(3)");
                String choice = myObj.nextLine();
                if (Integer.parseInt(choice) == 1) { //yes you could just use a string instead of int
                    list();
                } else if (Integer.parseInt(choice) == 2) {

                    System.out.println("Insert the number you want to rent");
                    String stock_id = myObj.nextLine();  // Read user input
                    rent(Integer.parseInt(student_id), Integer.parseInt(stock_id));
                } else if (Integer.parseInt(choice) == 3) {
                    System.out.println("Insert the number you want to cancel");
                    String stock_id = myObj.nextLine();  // Read user input
                    cancel(Integer.parseInt(student_id), Integer.parseInt(stock_id));
                } else {
                    loop=false;

                }

            }
    }
    public static void list() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:1433/sms", "postgres", "bert");
        connection.setAutoCommit(false);
        try {

            Statement stat = connection.createStatement();
            ResultSet rs = stat.executeQuery("SELECT * FROM stock WHERE cast(amount as int) > 0");

            while(rs.next())
            {
                String text = "";
                for(int i = 1; i <= 5 ; i++)
                {
                    text += rs.getString(i) + ":";
                }
                System.out.println(text);
            }
            connection.commit();
            stat.close();
            rs.close();

        } catch (SQLException e) {
            e.printStackTrace();
            connection.rollback();
        }
        connection.close();
    }
    public static void rent(int student_id, int stock_id) throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:1433/sms", "postgres", "bert");
        connection.setAutoCommit(false);
        try {
            Statement stat = connection.createStatement();
            String save = "SELECT cast(amount as int) as total FROM stock WHERE id=" + stock_id;
            String check = "SELECT COUNT(student_id) as total FROM rented_instruments WHERE student_id=" + student_id +" AND is_rented=true";
            ResultSet rstsave = stat.executeQuery(check);
            rstsave.next();
            if(rstsave.getInt("total") <2 ){
                ResultSet rst = stat.executeQuery(save);
                rst.next();
                if(rst.getInt("total") > 0) {
                    String query1 = "INSERT INTO rented_instruments VALUES(" + stock_id + "," + student_id + ", CURRENT_DATE, CURRENT_DATE+365,true)";
                    String query2 = "UPDATE stock SET amount=cast(amount as int)-1 WHERE id=" + stock_id;
                    int rs1 = stat.executeUpdate(query1);
                    int rs2 = stat.executeUpdate(query2);
                    System.out.println("Renting complete");
                }else{
                    System.out.println("There is no instrument left of that type to rent!");


                }
            }else{
                System.out.println("you cant rent more than 2 instruments!");

            }


            connection.commit();
            stat.close();


        } catch (SQLException e) {
            e.printStackTrace();
            connection.rollback();
        }
        connection.close();
    }
    public static void cancel(int student_id, int stock_id) throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:1433/sms", "postgres", "bert");
        connection.setAutoCommit(false);
        try {
            Statement stat = connection.createStatement();

            String query1 = "UPDATE rented_instruments SET is_rented=false WHERE (stock_id=" + stock_id + ") AND (student_id=" + student_id + ")";
            String query2 = "UPDATE stock SET amount=cast(amount as int)+1 WHERE id=" + stock_id;
            int rs1 = stat.executeUpdate(query1);
            int rs2 = stat.executeUpdate(query2);

            System.out.println("We have canceled rent with id " + stock_id);
            stat.close();
            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            connection.rollback();
        }
        connection.close();
    }

}