#include <EEPROM.h>
#define EEPROM_SIZE 1
#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>

#define SERVICE_UUID        "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"

const int redLED = 32;
const int blueLED = 33;
const int greenLED = 25;
const int resetButton = 26;
const int bigButton = 27;
int lastBigState = 0;
int valAddress = 0; // 8th byte, same in hexa as decimal
int valToWrite = 3;
int counter = 0;
char buf[50];
int maxVal;
  BLEServer *pServer = BLEDevice::createServer();
  BLEService *pService = pServer->createService(SERVICE_UUID);

  BLEAdvertising *pAdvertising = pServer->getAdvertising();
  BLECharacteristic *pCharacteristic = pService->createCharacteristic(
                                         CHARACTERISTIC_UUID,
                                         BLECharacteristic::PROPERTY_READ |
                                         BLECharacteristic::PROPERTY_WRITE
                                       );
void setup() {
  // put your setup code here, to run once:
  //36
  EEPROM.begin(EEPROM_SIZE);
  EEPROM.write(valAddress, valToWrite);
  EEPROM.commit();
  pinMode(redLED, OUTPUT);
  pinMode(blueLED, OUTPUT);
  pinMode(greenLED, OUTPUT);
  pinMode(resetButton, INPUT);
  pinMode(bigButton, INPUT);
  Serial.begin(9600);
  maxVal = EEPROM.read(valAddress);
  // BLE
  BLEDevice::init("MyESP32");
  pCharacteristic->setValue("Hello World says Peter");
  pService->start();
  pAdvertising->start();
pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(true);
  pAdvertising->setMinPreferred(0x06);  // functions that help with iPhone connections issue
  pAdvertising->setMinPreferred(0x12);
  BLEDevice::startAdvertising();
Serial.println("Characteristic defined! Now you can read it in your phone!");

}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(redLED, HIGH);
  int bigState = digitalRead(bigButton);
  digitalWrite(blueLED, bigState);
  
  int resetState = digitalRead(resetButton);
  if (resetState) {
    counter = 0;
    pCharacteristic->setValue("Value is reset to 0");
  }
  
  if (bigState == HIGH && lastBigState == LOW) {
    
    counter++;
    pCharacteristic->setValue(counter);
  }
  lastBigState = bigState;
  digitalWrite(greenLED, counter >= maxVal);
  
  //sprintf(buf, "BIG %d SMALL %d MAX %d AT %d\n",bigState,resetState,maxVal, counter);
  //Serial.print(buf);
}
