import processing.video.*;

class Camera {
  Capture cam;
  PApplet p5;
  int picNumber;
  String lastImg;
  String path;
  Camera(PApplet p5, Capture cam, String path)
  {
    this.cam = cam;
    this.p5 = p5;
    this.path = path;
    picNumber = 0;
    setup();
  }

  void setup() {
    //cam.start();
  }

  void draw() {
    if (cam.available() == true) {
      cam.read();
    }
    pushMatrix();
    scale(-1.0, 1.0);
    image(cam, -cam.width, 0);
    popMatrix();
    // The following does the same, and is faster when just drawing the image
    // without any additional resizing, transformations, or tint.
    //set(0, 0, cam);
  }

  String takePic()
  {
    if (!cam.available())
    {
      cam.read();
      String imgName = "youknowme";
      String destFile = path + imgName +"_"+ picNumber + ".jpg";
      lastImg = destFile;
      picNumber++;
      cam.save(destFile);
    } 
    return lastImg;
  }
}

