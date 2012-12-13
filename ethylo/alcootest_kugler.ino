/*
* A simple programme that will change the intensity of
 * an LED based  * on the amount of light incident on
 * the photo resistor.
 *
 */
#define WAIT 0;
#define MEASURE 1;
#define HOLD 2;

int state;
//PhotoResistor Pin
int alcoPin = 0; //the analog pin the photoresistor is
//connected to
//the photoresistor is not calibrated to any units so
//this is simply a raw sensor value (relative light)
int lastValue;
int timer;
int threshold; // minimum value at which you start displaying lights
//LED Pin
int ledPin1 = 8;   
int ledPin2 = 9;
int ledPin3 = 10;
int ledPin4 = 11;
int ledPin5 = 12;
//the pin the LED is connected to
//we are controlling brightness so
//we use one of the PWM (pulse width
// modulation pins)
void setup()
{
  Serial.begin(9600);

  pinMode(ledPin1, OUTPUT); //sets the led pin to output
  pinMode(ledPin2, OUTPUT); //sets the led pin to output
  pinMode(ledPin3, OUTPUT); //sets the led pin to output
  pinMode(ledPin4, OUTPUT); //sets the led pin to output
  pinMode(ledPin5, OUTPUT); //sets the led pin to output
  state = 0;
  lastValue = 0;
  threshold = 600;
}
/*
* loop() – this function will start after setup
 * finishes and then repeat
 */
int lastState = 1000;
void loop()
{
  if(lastState!=state)
  {
    lastState = state;
    Serial.print("state: ");
    Serial.println(state);
  }
  
  int alcoLevel = analogRead(alcoPin);


  switch(state)
  {
  case 0:
    analogWrite(ledPin1, 0);
    analogWrite(ledPin2, 0);
    analogWrite(ledPin3, 0);
    analogWrite(ledPin4, 0);
    analogWrite(ledPin5, 0);
    //if you detect enough, display it.
    if(alcoLevel > threshold)
    {
      state = 1;
    }
    break;

  case 1: // measure
    //Save largest value
    lastValue = max(alcoLevel, lastValue);
    Serial.print("state: ");
    Serial.print(state);
    Serial.print(": ");
    Serial.print(alcoLevel);
    Serial.print(", ");
     Serial.println(lastValue);
    //display it
    writeLevel(lastValue);
    //once it came back down, go to HOLD
    if(alcoLevel < threshold)
    {
      state = 2; 
    }
    break;

  case 2:
    Serial.print("state: ");
    Serial.print(state);
    Serial.print(": ");
    Serial.print(alcoLevel);
    Serial.print(", ");
    Serial.println(lastValue);
    writeLevel(lastValue);
    lastValue -=10;
    delay(50);
    Serial.print(alcoLevel);
    Serial.print(", ");
     Serial.println(lastValue);
    if(lastValue <= 0)
    {
      state = 0;
    }
    break;
  }
}

void writeLevel(int value)
{

  if (value > 326){
    lightUp(value, ledPin1, 210, 326);
  }
  if (value > 421){
    lightUp(value, ledPin2, 421, 515);
  }
  if (value > 516){
    lightUp(value, ledPin3, 516, 610);
  }
  if (value > 611){
    lightUp(value, ledPin4, 611, 705);
  }
  if (value > 706){
    lightUp(value, ledPin5, 706, 800);
  } 
}
void lightUp(int lightLevel, int ledPin, int min_, int max_)
{
  lightLevel = map(lightLevel, min_, max_, 0, 255);
  lightLevel = constrain(lightLevel, 0, 255); 
  analogWrite(ledPin, lightLevel);  //write the value 
}


