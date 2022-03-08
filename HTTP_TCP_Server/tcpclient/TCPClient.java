package tcpclient;
import java.net.*;
import java.io.*;
import java.util.Arrays;

public class TCPClient {
    boolean shutdowns;
    Integer timeouts;
    Integer limits;
    public TCPClient(boolean shutdown, Integer timeout, Integer limit) {
        shutdowns = shutdown;
        timeouts = timeout;
        limits = limit;
    }

    public byte[] askServer(String hostname, int port, String toServerBytes) throws IOException {
        byte[] serverbuffer = new byte[2000];
        ByteArrayOutputStream inputbuffer = new ByteArrayOutputStream();
        try (Socket clientsocket = new Socket()) {

        SocketAddress socketaddress = new InetSocketAddress(hostname, port);
        if(timeouts == null)
        {
            timeouts = 0;
        }
        clientsocket.connect(socketaddress, timeouts);
        clientsocket.setSoTimeout(timeouts);
        if(toServerBytes != null)
        {
            toServerBytes = toServerBytes + "\n";
            byte[] yep = toServerBytes.getBytes("UTF-8");
            OutputStream out = clientsocket.getOutputStream();
            out.write(yep);
        }
        if(shutdowns)
        {
            clientsocket.shutdownOutput();
        }

        InputStream in = clientsocket.getInputStream();
        int read;
        


        if(limits == null)
        {
            while((read = in.read(serverbuffer)) != -1)
        {
            inputbuffer.write(serverbuffer, 0, read);
        }
        }
        else
        {
        boolean hitceil = true;
        while((read = in.read(serverbuffer, 0, limits)) != -1 && hitceil)
        {
            if(read == limits) hitceil = false;

            inputbuffer.write(serverbuffer, 0, read);
        }
        }
        in.close();
        clientsocket.close();
        }
        catch (SocketTimeoutException e) {
            System.out.println(e.getMessage());
            }
        catch (UnknownHostException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException("404");
            
        } catch (IOException e) {
        System.out.println(e.getMessage());
        }
        catch (NullPointerException e) {
            System.out.println(e.getMessage());
            }
            catch (ArrayIndexOutOfBoundsException e) {
                System.out.println(e.getMessage());
                }
        return inputbuffer.toByteArray();
    }
}
