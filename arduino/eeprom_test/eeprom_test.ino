#include <EEPROM.h>

int red = 13, blue = 12, green = 11;
int reset = 5, big = 2;
int lastBigState = 0;
int valAddress = 0x08; // 8th byte, same in hexa as decimal
int valToWrite = 2;
int counter = 0;
char buf[50];

int maxVal;
void setup() {
  EEPROM.update(valAddress, valToWrite); // only writes if different
  pinMode(red, OUTPUT);
  pinMode(blue, OUTPUT);
  pinMode(green, OUTPUT);

  pinMode(reset, INPUT);
  pinMode(big, INPUT);
  Serial.begin(9600);
  maxVal = EEPROM.read(valAddress);
}
void loop() {
  int bigState = digitalRead(big);
  digitalWrite(blue, bigState);
  
  int resetState = digitalRead(reset);
  if (resetState) {
    counter = 0;
  }
  
  if (bigState == HIGH && lastBigState == LOW) {
    counter++;
  }
  lastBigState = bigState;
  digitalWrite(green, counter >= maxVal);
  
  sprintf(buf, "BIG %d SMALL %d\n",bigState,resetState);
  Serial.print(buf);
  

}
