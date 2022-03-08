import tcpclient.*;
import java.net.*;
import java.util.Arrays;
import java.io.*;
import java.lang.Runnable;
public class MyRunnable implements Runnable {

    private Socket socket;

    public MyRunnable(Socket newClient) 
    {
        this.socket = newClient;
    }

    public void run() {
 
        try
        {
            int read;
            byte[] serverbuffer = new byte[2000];
            ByteArrayOutputStream inputbuffer = new ByteArrayOutputStream();

            OutputStream out = socket.getOutputStream();
            InputStream in = socket.getInputStream();

                while ((read = in.read(serverbuffer)) != -1) {
                    inputbuffer.write(serverbuffer, 0, read);
                    if(serverbuffer[serverbuffer.length-1] == 0)
                    {
                         break;
                    }
                }
            
            String string = inputbuffer.toString("UTF-8");
            String[] lines = string.split(System.getProperty("line.separator"));
            if(lines[0].length() > 0)
            {
                boolean typo = true;
                if(lines[0].contains("GET /ask?") && lines[0].contains("HTTP/1.1") && lines[0].contains("/favicon.ico") == false)
                {
                    typo = false;
                }
                
            String text = lines[0].substring(lines[0].indexOf("?") + 1, lines[0].indexOf("HTTP/1.1") - 1);
            
            String[] split = text.split("&");
            String hostname = null;
            String port = null;
            String limit = null;
            String timeout = null;
            String inputtext = "";
            Boolean shutdown = false;
            for(int i = 0; i < split.length ; i++)
            {
                String[] var = split[i].split("=");
                if(var[0].contains("hostname"))
                {
                    hostname = var[1];
                }
                else if(var[0].contains("limit"))
                {
                    limit = var[1];
                }
                else if(var[0].contains("string"))
                {
                    inputtext = var[1];
                }
                else if(var[0].contains("shutdown"))
                {
                    shutdown = true;
                }
                else if(var[0].contains("timeout"))
                {
                    timeout = var[1];
                }
                else if(var[0].contains("port"))
                {
                    port = var[1];
                }

            }
            Integer lim = null;
            Integer tim = null;
            if(limit != null)
            {
                lim = Integer.parseInt(limit);
            }
            if(timeout != null)
            {
                tim  = Integer.parseInt(timeout);
            }
            TCPClient tcpClient = new TCPClient(shutdown, tim, lim);
        if(hostname != null && port != null && !typo)
        {
                try{
                byte[] outprint = tcpClient.askServer(hostname, Integer.parseInt(port), inputtext);
                out.write("HTTP/1.1 200 OK\r\n".getBytes());
                out.write("\r\n".getBytes());
                out.write(outprint);
                out.write("\r\n\r\n".getBytes());
                out.flush();
                }
                catch(RuntimeException e)
                {
                    System.out.println("404");
                    out.write("HTTP/1.1 404 Not Found\r\n".getBytes());
                    out.write("\r\n".getBytes());
                    out.write("404 Not Found".getBytes());
                    out.write("\r\n\r\n".getBytes());
                    out.flush();
                }
        }
        else
        {
            System.out.println("400");
                out.write("HTTP/1.1 400 Bad Request\r\n".getBytes());
                out.write("\r\n".getBytes());
            out.write("400 Bad Request".getBytes());
                out.write("\r\n\r\n".getBytes());
                out.flush();
        }
        }
        in.close();
        out.close();
        socket.close();

        }
        catch(SocketException e)
        {
            System.out.println(e.getMessage());
        }
    catch (IOException e) {
        System.out.println(e.getMessage());
        }


}
}