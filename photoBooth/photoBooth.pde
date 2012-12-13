import fullscreen.*;
import japplemenubar.*;

import javax.activation.*;
import com.sun.activation.viewers.*;
import com.sun.activation.registries.*;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

import com.sun.mail.smtp.*;

import processing.serial.*;
import processing.video.*;

FullScreen fs;

Camera myCam;
Capture cam;
Mail myMail;
mailList myList;
Ard myArd;
String resourcePath;
Serial myPort;
int countdown;  //var used for countdown
int state; //1: waiting, 2: taking picture, 3: displaying picture
String nextAddress;

void setup() {
  size(1280, 720);
  frameRate(30);
  fs = new FullScreen(this);
  fs.setShortcutsEnabled(true);
  resourcePath = "/Users/Gaston/eclipse/kuglerSend/src/data/";
  myMail = new Mail(resourcePath);
  myList = new mailList(this, resourcePath);
  myArd = new Ard();
  myPort = new Serial(this, Serial.list()[6], 9600);
  String[] cameras = Capture.list();
  print(cameras);
  //Remove 0 to print cameras list
  if (cameras.length == 0 && true) 
  {
    println("There are no cameras available for capture.");
    exit();
  } 
  else 
  {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) 
    {
      println(cameras[i]);
    }
    // The camera can be initialized directly using an 
    cam = new Capture(this, 768, 576, cameras[1], 30);
    myCam = new Camera(this, cam, resourcePath);
  }
}

void draw() {
  background(0);
   rectMode(CORNER);
   switch(state)
  {
  case 0:
    myCam.draw();
    drawText("Press the button");
    countdown = 100;
    break;

  case 1:
    //Wait for camera to send the signal
    if (countdown-- <= 0)
    {
      state = 2;
      countdown = round(5*frameRate);
      picAndSend();
    }
    myCam.draw();
    String c =  (ceil(countdown/frameRate) != 0) ? Integer.toString(ceil(countdown/frameRate)) : "Smile!";
    drawText(c);
    break;
  case 2:
    //Print image and text

    if (countdown-- <= 0)
    {
      state = 0;
    }
    myCam.draw();
    drawText("Your picture was sent to "+nextAddress+"!");
    break;
  }
}

void drawText(String txt)
{
    if(txt != null)
    
    fill(255);
    textSize(32);
    text(txt, 0, 0, width/2, height/2);
}

public void picAndSend()
{
  myMail.sendMail(myCam.takePic(), nextAddress);
  myList.getAddress();
}

public void serialEvent(Serial myPort)
{
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null && state == 0) {
    // trim off any whitespace:
    //inString = p5.trim(inString);
    inString = inString.replace('\n', ' ');
    //println(inString);
    // convert to an int and map to the screen height:
    boolean inByte = inString.contains("1023"); 
    if (inByte && state == 0)
    {
      state = 1;
      countdown = 150;
      nextAddress = myList.getAddress();

    }
  }
  
  if(myArd.trigger(myPort) && state == 0)
  {
      //state = 1;
      //nextAddress = myList.getAddress();
      println("pressed");
      nextAddress = myList.getAddress();

  }
}


public void keyPressed()
{
  if (key == 's')
  {
   state = 1;
   nextAddress = myList.getAddress();
  }
  else if (key == 'p')
  {
   myList.printAdd();
  }
}

