
class Mail {
  // Daniel Shiffman               
  // http://www.shiffman.net       
  // Example functions that check mail (pop3) and send mail (smtp)
  // You can also do imap, but that's not included here

  PApplet p5;
  String resourcePath;
  
  Mail(String path) {
    resourcePath = path;
  }
  // Daniel Shiffman               
  // http://www.shiffman.net       

  // Example functions that check mail (pop3) and send mail (smtp)
  // You can also do imap, but that's not included here

  // A function to check a mail account
  void checkMail() {
    try {
      Properties props = System.getProperties();

      props.put("mail.pop3.host", "pop.gmail.com");

      // These are security settings required for gmail
      // May need different code depending on the account
      props.put("mail.pop3.port", "995");
      props.put("mail.pop3.starttls.enable", "true");
      props.setProperty("mail.pop3.socketFactory.fallback", "false");
      props.setProperty("mail.pop3.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

      // Create authentication object
      Auth auth = new Auth();

      // Make a session
      Session session = Session.getDefaultInstance(props, auth);
      Store store = session.getStore("pop3");
      store.connect();

      // Get inbox
      Folder folder = store.getFolder("INBOX");
      folder.open(Folder.READ_ONLY);
      System.out.println(folder.getMessageCount() + " total messages.");

      // Get array of messages and display them
      Message message[] = folder.getMessages();
      for (int i=0; i < message.length; i++) {
        System.out.println("---------------------");
        System.out.println("Message # " + (i+1));
        System.out.println("From: " + message[i].getFrom()[0]);
        System.out.println("Subject: " + message[i].getSubject());
        System.out.println("Message:");
        String content = message[i].getContent().toString(); 
        System.out.println(content);
      }

      // Close the session
      folder.close(false);
      store.close();
    } 
    // This error handling isn't very good
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  // A function to send mail
  void sendMail(String path, String dest) {
    // Create a session
    String host="smtp.gmail.com";
    Properties props=new Properties();

    // SMTP Session
    props.put("mail.transport.protocol", "smtp");
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", "25");
    props.put("mail.smtp.auth", "true");
    // We need TTLS, which gmail requires
    props.put("mail.smtp.starttls.enable", "true");

    // Create a session
    Session session = Session.getDefaultInstance(props, new Auth());
    try
    {
      // Make a new message
      MimeMessage message = new MimeMessage(session);

      // Who is this message from
      message.setFrom(new InternetAddress("info@insan-e.net", "Compagnie insane"));

      // Who is this message to (we could do fancier things like make a list or add CC's)
      message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(dest, false));

      // Subject and body
      message.setSubject("Hello World!");

      message.setContent(makeContent(path));
      // We can do more here, set the date, the headers, etc.
      Transport.send(message);
      System.out.print("Mail sent to ");
      System.out.print(dest);
      System.out.println("!");
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
  }



  Multipart makeContent(String path)
  {
    Multipart multipart = new MimeMultipart("related");

    try
    {
      BodyPart htmlPart = new MimeBodyPart();

      htmlPart.setContent("<div style=\"word-wrap:break-word\"><div><br></div><div><br></div><div><br><br><table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"font-family:Tahoma;font-size:13px\"><tbody><tr><td valign=\"top\" align=\"center\"><table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tbody><tr><td>"+
        "<img width=\"600px\" height=\"194\" src=\"cid:logo\" style=\"max-width:100%;border-top-style:solid;border-bottom-style:solid;border-top-width:1px;border-right-width:1px;border-bottom-width:1px;border-left-width:1px;border-top-color:rgb(192,192,192);border-right-color:rgb(192,192,192);border-bottom-color:rgb(192,192,192);border-left-color:rgb(192,192,192);border-left-style:none;border-right-style:none\"> "+
        "</td></tr></tbody></table></td></tr><tr><td valign=\"top\" align=\"center\"><table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tbody><tr><td valign=\"top\"><table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tbody><tr><td valign=\"top\"><div><h1><span class=\"il\">NEWSLETTER</span> | insanë</h1></div>"+
        "<div style=\"margin-right:30px;margin-bottom:10px;margin-left:30px\"><h1></h1><h2>Résidence de recherche et de création</h2><h3>Fonderie Kugler | Genève</h3><h4></h4><br><b>SOIREE INSANË A LA FONDERIE KUGLER</b><br>Clôture de la résidence de création&nbsp;<br><br><b>LE 14 DECEMBRE 2012</b><br>DE 18h à 5h&nbsp;<br><br>La saison 2012/2013 de la compagnie, basée sur la prise de parole dans l'espace public, cherche à créer des liens entre théâtre, installations, performances et public. Du 3 au 14 décembre nous investissons la Fonderie Kugler afin de transformer son espace en univers insanë. Nous chercherons à revisiter cet espace pour le réinventer, le remodeler et questionner le privé dans le public comme le public dans le privé. En intégrant les nouvelles technologies à notre processus de travail, nous sommes sans cesse à la recherche du langage de demain, tout en se confrontant aux réalités d'aujourd'hui.&nbsp;</div><div style=\"margin-right:30px;margin-bottom:10px;margin-left:30px\"><span style=\"font-family:'Open Sans',arial,serif;font-size:12px;line-height:18px\">Après une rencontre plus conventionnelle en début de soirée autour d'une présentation des installations performances créées pendant la résidence, &nbsp;l’univers d’insanë à la Fonderie Kugler prendra une allure plus festive dès 23h. Entre découvertes artistiques et party, insanë proposera aux noctambules une soirée de qualité, à la fois fête décontractée et expérience culturelle forte.<br style=\"margin-top:0px;margin-right:0px;margin-bottom:0px;margin-left:0px;padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;font-weight:inherit;font-style:inherit;font-size:12px;font-family:inherit;vertical-align:baseline\">Pour cette soirée, insanë s’associe aux deux DJs romands Guillaume Peitrequin et Lionel Coudray. Ceux-ci vous proposeront un set sur-mesure comme vous n’en trouverez pas ailleurs, jusqu’au bout de la nuit. Après un début de soirée 70′s funky et afrobeat, laissez-vous emmener par les rythmes disco et house de ces deux DJs qui ont déjà mis le feu à la plupart des clubs romands.</span><br><br><b>Au programme de cette soirée:</b>&nbsp;<br><br>18h30 Table ronde - La prise de parole dans l'espace public (en partenariat avec le journal&nbsp;<a target=\"_blank\" href=\"http://www.lacite.info/\">La Cité</a>et le journal en ligne&nbsp;<a target=\"_blank\" href=\"http://www.lameduse.ch/\">La Méduse</a>)&nbsp;<br><br>20h00 Repas convivial&nbsp;<br><br>21h30 Performances installations&nbsp;<br><br>23h00 Party - Guillaume P (RHYTHM CYCLES) &amp; Lionel Coudray (BORN BJORG)&nbsp;<br><br>Entrée libre jusqu’à 21h00 &ndash; 10CHF jusqu’à minuit &ndash; 12 CHF après minuit&nbsp;<br><br>Plus d'infos sur:&nbsp;<a target=\"_blank\" href=\"http://www.insan-e.net/residence-kugler/\">http://www.insan-e.net/<wbr></wbr>residence-kugler/</a>&nbsp;<br><br><i>Fonderie Kugler, 4bis rue de la Truite, 1205 Genève</i></div></td></tr></tbody></table></td></tr></tbody></table></td></tr><tr><td valign=\"top\" align=\"center\"><br><table width=\"600\" cellspacing=\"0\" cellpadding=\"10\" border=\"0\"><tbody><tr><td valign=\"top\"><table width=\"100%\" cellspacing=\"0\" cellpadding=\"10\" border=\"0\"><tbody><tr><td valign=\"middle\" colspan=\"2\"><div>&nbsp;<a target=\"_blank\" href=\"http://www.twitter.com/compagnieinsane\">Suivez-nous sur Twitter</a>&nbsp;|&nbsp;<a target=\"_blank\" href=\"http://www.facebook.com/compagnieinsane\">Suivez-nous sur Facebook</a>&nbsp;|&nbsp;<a target=\"_blank\" href=\"http://www.vimeo.com/compagnieinsane\">Suivez-nous sur Vimeo</a>&nbsp;</div></td></tr><tr><td valign=\"middle\" colspan=\"2\"><div>&nbsp;<a target=\"_blank\" href=\"http://admin.insan-e.net/mail/newsletter/user/index.php?sExternalid=b0fe6499ba57728a2f2aeb11969fa8bf\">Se désinscrire de cette <span class=\"il\">newsletter</span></a>&nbsp;|&nbsp;<a target=\"_blank\" href=\"http://admin.insan-e.net/mail/newsletter/user/index.php?sExternalid=b0fe6499ba57728a2f2aeb11969fa8bf\">Modifier mon abonnement</a>&nbsp;</div></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><div class=\"yj6qo\"></div><div class=\"adL\"><br></div></div></div>" + 
        "<img src=\"cid:the-img-1\" style=\"max-width:600px\"/><br/> some more text</body></html>", "text/html");

      multipart.addBodyPart(htmlPart);

      //adding the logo
      BodyPart logo=new MimeBodyPart();
      DataSource dsLogo=new FileDataSource(resourcePath+"logo.jpg");
      logo.setDataHandler(new DataHandler(dsLogo));

      //Setting the header
      logo.setFileName("logo.jpg");
      logo.setHeader("Content-ID", "<logo>");
      multipart.addBodyPart(logo);

      // Loading the image
      BodyPart imgPart=new MimeBodyPart();
      DataSource ds=new FileDataSource(path);
      imgPart.setDataHandler(new DataHandler(ds));

      //Setting the header
      imgPart.setFileName(path);
      imgPart.setHeader("Content-ID", "<the-img-1>");
      multipart.addBodyPart(imgPart);
    }
    catch(Exception e)
    {
    }
    return multipart;
  }
}

