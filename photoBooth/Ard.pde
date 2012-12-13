class Ard{
  
 boolean trigger(Serial myPort)
{
 // get the ASCII string:
     String inString = myPort.readStringUntil('\n');
     boolean inByte = false;
     if (inString != null && state == 0) {
       // trim off any whitespace:
       //inString = p5.trim(inString);
       inString = inString.replace('\n',' ');
       // convert to an int and map to the screen height:
       inByte = inString.contains("1023"); 
     }
     return inByte;
} 
  
  
}
