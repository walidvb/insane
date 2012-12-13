int cameraUsbPin = 13;
int inputPin = 0;

void setup() {
  pinMode(cameraUsbPin, OUTPUT);
  pinMode(inputPin, INPUT);
  }
  
  void loop(){
    int lightLevel = analogRead(inputPin);
    //lightLevel = map(lightLevel, 0, 900, 0, 255);
    //lightLevel = constrain(lightLevel, 0, 255);
    if (lightLevel > 50){
  digitalWrite(cameraUsbPin, LOW);
  }
  if (lightLevel <= 50){
  digitalWrite(cameraUsbPin, HIGH);
     }
     }


