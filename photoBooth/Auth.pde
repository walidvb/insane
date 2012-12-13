
public class Auth extends Authenticator {
  
  public Auth() {
   super();
  }
  
  public PasswordAuthentication getPasswordAuthentication() {
     String username, password;
     username = "compagnieinsane";
     password = "mixturae";
     System.out.println("authenticating. . ");
     return new PasswordAuthentication(username, password);
  }
}
