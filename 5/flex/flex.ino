const int flexPin = A0; 
int led1=A1;
int led2=A2;
void setup() 
{ 
  Serial.begin(9600);
} 
 
void loop() 
{ 
  int flexValue;
  flexValue = analogRead(flexPin);
  Serial.print("sensor: ");
  Serial.println(flexValue);
  if (flexValue>700){
    digitalWrite(led1,1);
    }
    else  digitalWrite(led1,0);

    if (flexValue<450) digitalWrite(led2,1);     
    else  digitalWrite(led2,0);
  delay(20);
} 
