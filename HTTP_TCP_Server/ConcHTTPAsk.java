import java.net.*;
import java.io.*;
import java.lang.Runnable;
public class ConcHTTPAsk {
    public static void main(String[] args) throws IOException
    {
        try(ServerSocket server = new ServerSocket(Integer.parseInt(args[0])))
        {
            while(true)
            {
                Socket socket = server.accept();
                MyRunnable newclient = new MyRunnable(socket);
                new Thread(newclient).start();
            }
        }
        catch(SocketException e)
        {
            System.out.println(e.getMessage());
        }
        catch (IOException e)
        {
             System.out.println(e.getMessage());
        }        
    }
}

