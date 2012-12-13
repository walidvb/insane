import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Random;
import processing.core.PApplet;

class mailList {
  ArrayList<String> addressList;
  int index;
  PApplet p5;
  String resourcePath;
  
  mailList(PApplet p5, String rPath)
  {
    this.p5 = p5;
    resourcePath = rPath;
    addressList = new ArrayList<String>();
    populateList();
  }
  
  void populateList()
  {
      try
      {
          // Open the file that is the first 
          // command line parameter
          FileInputStream fstream = new FileInputStream(resourcePath + "addresses.txt");
          // Get the object of DataInputStream
          DataInputStream in = new DataInputStream(fstream);
          BufferedReader br = new BufferedReader(new InputStreamReader(in));
          String strLine;
          
          //Read File Line By Line
          while ((strLine = br.readLine()) != null && !strLine.equals(""))   {
          // Print the content on the console
            addressList.add(strLine);
          }
          //Close the input stream
          in.close();
        }catch (Exception e){//Catch exception if any
          System.err.println("Error: " + e);
      }
          
  }
  
  String getAddress()
  {
    String address = null;
    Random index = new Random();
    address = addressList.remove(index.nextInt(addressList.size()));
    print(addressList.size());
    if(addressList.size() == 0)
    {
      populateList();
    }
    return address;
  }
  
  void printAdd()
  {
    print(addressList.size());
    print(addressList);
  }
}
