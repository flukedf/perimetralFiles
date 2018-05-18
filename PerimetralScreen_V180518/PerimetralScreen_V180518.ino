#include <Wire.h>
#include <Console.h>
#include <Process.h>
#include <Adafruit_ADS1015.h> 
/*========================================*/
/*===========Gmail========================*/
#include <Bridge.h>
/*========================================*/
#include <avr/pgmspace.h>
/*=============ADC ADS1115===========================*/
Adafruit_ADS1115 ads01(0x48);
Adafruit_ADS1115 ads02(0x49);
int goAmp = 0;
double sqI,sumI;
double sampleI;
double Irms;
double squareRoot(double fg)
{
    double n = fg / 2.0;
    double lstX = 0.0;
    while (n != lstX)
    {
        lstX = n;
        n = (n + fg / n) / 2.0;
    }
    return n;
}
double calcIrms(unsigned int Number_of_Samples, float multiplier,double ical)
{
     for (unsigned int n = 0; n < Number_of_Samples; n++)
    {
   
                      if(goAmp==0){

                          sampleI = (double)ads01.readADC_Differential_0_1();
         
                      }
                      if(goAmp==1){
                          sampleI = (double)ads01.readADC_Differential_2_3();
                      }
                      if(goAmp==2){
                          sampleI = (double)ads02.readADC_Differential_0_1();
                      }
                      if(goAmp==3){
                          sampleI = (double)ads02.readADC_Differential_2_3();
                      }
   
        sqI = sampleI * sampleI;
        sumI += sqI;
    }
    Irms = squareRoot(sumI / Number_of_Samples) * multiplier * ical;
    sumI = 0;
   return Irms;
}
/*============Final ADC ads1115============================*/

/*========================================*/
/*========================================*/
const String Access = "|Access Sensor";
const String Magnetic = "|Magnetic Sensor";
const String Disarm = "|Disarm Sensor";
const String Phase = "|Phase Sensor";
const String Light = "|Light Sensor";
const String NotDefined = "|Not defined";

String clocks = "";

//#define PCF_address 0x20//B0100000

int PCF_address[]={32,34};
#define bit[7]
Process date;                 // process used to get the date
int hours, minutes, seconds;  // for the results
int lastSecond = -1;          // need an impossible value for comparison
int pi=0;
int A[]={0,0,0,0,0,0,0,0};
int timeMin[]={1,1,1,1,1,1,1,1,1,1,1};
float PH[]={0.0,0.0,0.0};

int statusBridge = 0;

int numPto = 0;
int startPto = 0;
int workTime = 0;
String typeSensor = "";
//int nom_sensor = 0;
int deviceEmail=0;
int bits[] = {0,1,2,4,8,16,64,128,256};
int bit_check = 0;
byte cap = 0x00;
byte read_pto=0; 
byte test=0;

boolean value;
int incomingByte;
String name = "";
char x;
String inString = ""; 
int valor = 0;


char lbuffer[2]="0";
int variable = 0;


void clearAndHome()
{
/*  Serial.write(27);
  Serial.print("[2J"); // clear screen
  Serial.write(27);
  Serial.print("[H"); // cursor to home
*/

  Console.write(27); //Solo funciona en consola
  Console.print("[2J"); // clear screen
  Console.write(27);
  Console.print("[H"); // cursor to home
//Console.print("[20;20H"); // cursor to home
Console.println(F("Consola...................."));
   Console.println(F("Referencia 0,0,100,100......"));
}

void columna2(){
                Console.print("[0;80H"); // cursor to home
}

void home()
{
  Console.write(27);
  Console.print("[H"); // cursor to home
}
void clear()
{
  Console.write(27); //Solo funciona en consola
  Console.print("[2J"); // clear screen
}

void scann(){
    Console.println (F("I2C Address Scanner. \nScanning ..........."));
  byte count = 0;
  
  Wire.begin();
  for (byte i = 1; i < 120; i++)
  {
    Wire.beginTransmission (i);
    if (Wire.endTransmission () == 0)
      {
      Console.print (F("Found i2c Device Address: "));
      Console.print (i, DEC);
      Console.print ("d (0x");
      Console.print (i, HEX);
      Console.print ("h)");
      int j = (i-32)+1;
      switch (j){
        case 1:
          Console.println (Magnetic);
          break;
        case 2:
          Console.println (Disarm);
          break;
        case 3:
          Console.println (NotDefined);
          break;
        case 4:
          Console.println (NotDefined);
          break;        
        case 5:
          Console.println (NotDefined);
          break;
        case 6:
          Console.println (NotDefined);
          break;
        case 7:
          Console.println (NotDefined);
          break;
        case 8:
          Console.println (NotDefined);
          break;                     
      }
int k = (i-56)+1;
      switch (k){
        case 1:
          Console.println (Phase);
          break;
        case 2:
          Console.println (Light);
          break;
        case 3:
          Console.println (NotDefined);
          break;
        case 4:
          Console.println (NotDefined);
          break;        
        case 5:
          Console.println (NotDefined);
          break;
        case 6:
          Console.println (NotDefined);
          break;
        case 7:
          Console.println (NotDefined);
          break;
        case 8:
          Console.println (NotDefined);
          break;                    
      }
int l = (i-72)+1;
      switch (l){
        case 1:
          Console.println (Phase);
          break;
        case 2:
          Console.println (Phase);
          break;
        case 3:
          Console.println (NotDefined);
          break;
        case 4:
          Console.println (NotDefined);
          break;        
        case 5:
          Console.println (NotDefined);
          break;
        case 6:
          Console.println (NotDefined);
          break;
        case 7:
          Console.println (NotDefined);
          break;
        case 8:
          Console.println (NotDefined);
          break;                    
      }

      
      count++;
      //delay (1);  
      } // end of good response
  } // end of for loop
  Console.println (F("Done."));
  Console.println (F("Found "));
  Console.print (count, DEC);
  Console.println (F(" device(s)."));
}  // end of setup
void minutesEmail(){
                    //Console.print("SentEmail \n"+String(timeMin[workTime]));
                    if(timeMin[workTime] == 1){
                                        sentMail();
                                        //delay(24000);
                                        //delay(120000);                                   
                                      }
                                  
                    if(timeMin[workTime] == 10){
                                                timeMin[workTime] = 1;
                                                Console.println("reiniciar a cero\n");
                                          }else{
                                            timeMin[workTime]= timeMin[workTime]+1;
                                            }
  }

void list_magnetic(){

   pi = 0;
   Console.print(String(typeSensor)+String(F("\n"))); 
    Console.print(F("==================================\n")); 
    for (int i=startPto;i<numPto;i++){
         processProg();
         Wire.requestFrom(PCF_address[pi],1);
         if(Wire.available())  
           read_pto = Wire.read();
            Console.print(String(typeSensor)+String(F("#"))+i);   
            Console.print("\t");
            test=bit_check&read_pto;
           if (test == 0){
               value = false;
               A[i] = 0;
               timeMin[i] = 1;
               Bridge.put(String("A")+String(i),String(value));
               }else{
                     value = true;
                     A[i] = 1;
                     Bridge.put(String("A")+String(i),String(value));
                     if(i<6){
                                  deviceEmail = 1;
                                  workTime = i;
                                  minutesEmail();

                     }
                     if(i>5){
                                  deviceEmail = 2;
                                  workTime = i;
                                  minutesEmail();
                     }                     
                    
                   }
           Console.print(String(F("VALUE "))+String(value)+String(F("\n")));
           bit_check = bit_check << 1;
           }
         Wire.endTransmission();
         Console.print(F("==================================\n"));

        }
void listADC(){
                Console.print(String(typeSensor)+String(F("\n"))); 
                Console.print(F("==================================\n"));
                for(int t=0;t<3;t++){
                                    processProg();
                                    if(goAmp==3){
                                                  goAmp=0;
                                                }
                                    double Irms = calcIrms(64, 0.125F,4.5) / 100;
                                    Console.print(((String("Hook "))+String(goAmp)+(String("\t")))); 
                                    Console.print((Irms*120.0)+String(" Watts"));        // Apparent power
                                    Console.print(" ");
                                    Console.println(Irms+(String(" Amps")));            // Irms
                                    PH[goAmp] = Irms;
                                    
                                    //timeMin[7+t] = 1;

                                    
                                    if(Irms <= 0.010){
                                      deviceEmail = 3;
                                      workTime = 8+t;
                                       //Console.println("Enviar email alerta electrica\n"+String(t)+String(F("\n"))+"deviceEmail "(F("\n\n\n")));
                                       //Console.println("variables "+String(workTime)+" "+String(timeMin[workTime]));
                                       Bridge.put("t", String(t));
                                       minutesEmail();
                                      //delay(1000);
                                      
                                         }



                                    
                                    Bridge.put(String("PH")+String(goAmp),String(Irms));
                                    goAmp += 1;
                                   }
              }
////////////////////////////////////////////////              
void time_check(){
    
  if (!date.running()) {
    date.begin("date");
    date.addParameter("+%T,%A,%d,%B,%Y");
    date.run();
  }
       
  //if there's a result from the date process, parse it:
  while (date.available() > 0) {
    // get the result of the date process (should be hh:mm:ss):
    String timeString = date.readString();
        Console.print(timeString);
    // find the colons:
    int firstColon = timeString.indexOf(":");
    int secondColon = timeString.lastIndexOf(":");

    // get the substrings for hour, minute second:
    String hourString = timeString.substring(0, firstColon);
    String minString = timeString.substring(firstColon + 1, secondColon);
    String secString = timeString.substring(secondColon + 1);
    // convert to ints,saving the previous second:
    hours = hourString.toInt();
    minutes = minString.toInt();
    lastSecond = seconds;          // save to do a time comparison
    seconds = secString.toInt();
   /*
    Console.println(minutes);
      if((hours == 00)||(hours == 12)){
        if(minutes == 01 ){
                    Console.println("Reboot 30 seg");
                    delay(30000);
                    Process resett;
                    resett.runShellCommand(F("reboot"));
                  }
      }
          */                                   
  
  }
 if (lastSecond != seconds) { // if a second has passed
    // print the time:
    if (hours <= 9) Console.print("0");    // adjust for 0-9
    Console.print(hours);
    Console.print(":");
    if (minutes <= 9) Console.print("0");  // adjust for 0-9
    Console.print(minutes);
    Console.print(":");
    if (seconds <= 9) Console.print("0");  // adjust for 0-9
    Console.println(seconds);
    // restart the date process:

  }
}
////////////////////////////////////////////////
void setup()
{
  pinMode(LED_BUILTIN, OUTPUT);

int statusBridge = 1;

for(int t=0;t<15;t++){  
    processProg();
}
 /* delay(2000); //The bare minimum needed to be able to reboot both linino and leonardo.
                          // if reboot fails try increasing this number
                          // The more you run on linux the higher this number should be
  Serial1.begin(115200); // Set the baud.
// Wait for U-boot to finish startup.  Consume all bytes until we are done.
  do {
     while (Serial1.available() > 0) {
        Serial1.read();
        }
    delay(1000);
  } while (Serial1.available()>0);

*/

  

Wire.begin();
//Serial.begin(9600);
Bridge.begin();
Console.begin();
ads01.setGain(GAIN_ONE);
ads01.begin();
ads02.setGain(GAIN_ONE);
ads02.begin();
Bridge.put("deviceEmail", String(deviceEmail));
Bridge.put("t", String("0"));
Bridge.put(String("statusBridge"),String(statusBridge));
}
///////////////////////////////////////////////
void serviceTime(){
                    time_check();
                    Console.print(F("==================================\n"));
                    Console.print(F("         Service Time\n")); 
                    Console.print(F("         Press Enter to Exit\n")); 
                    Console.print(F("==================================\n"));
                    Console.print(F("Introduzca los minutos de servicio\n"));
                    char readConsole = Console.read();
                    readConsole = "";
                    name = "";
                    do{
                        if (Console.available() > 0) {
                                       char readConsole = Console.read();
int inChar = readConsole;
    if (isDigit(inChar)) {
      // convert the incoming byte to a char
      // and add it to the string:
      inString += (char)inChar;
    }


                                       

                     
                                     if (readConsole == '\n') {

                                       int minutos = (inString.toInt());
                                       Console.print(F("minutos\n"));
                                       Console.println(minutos);                                    
                                       inString = "";                                  
                                            for (int i=0;i<(minutos*60);i++){
                                                    delay(1000);
                                                    //Console.print(F("."));
                                                    if((i%60)==0){
                                                      Console.print(F("\n"));
                                                    }
                                                    Console.print(F("."));
                                                    char readConsole = Console.read();
                                                    if(readConsole == '\n'){
                                                    name = "";
                                                    readConsole = "";                      
                                                    loop(); 
                                                                }
                                                                
                                                        }
                                        name = "";
                                        readConsole = "";                      
                                        loop();                                     
                                }else {
                                        name += readConsole; // append the read char from Console to the name string
                                       }
                              }
    }while(readConsole != '\n');
////////////////////////////////////////////////////
}
void current(){
                                        clear();
                                        home();
                                        time_check();
                                        maintenance();
                                        typeSensor = Access;
                                        numPto = 6;
                                        startPto = 0;
                                        bit_check = bits[1];
                                        list_magnetic();
                                       //delay(250);   
                                        typeSensor = Disarm;
                                        numPto = 8;
                                        startPto = 6;
                                        bit_check = bits[6];
                                        list_magnetic();  
                                        //delay(250);   
                                        typeSensor = Phase;
                                        listADC();
                                        //delay(250);
                                        postData();
                                        //delay(60000); 
                                        deviceEmail = 0;         
   
}
void maintenance(){
  Process Service;
  Service.runShellCommand(F("sudo python /root/service.py"));
  Bridge.get("statusBridge",lbuffer,2);
  variable = atoi(lbuffer);
  while(variable == 0){
              clear();
              home();
              time_check();
              Console.print(F("==================================\n"));
              Console.print(F("==================================\n"));                         
              Console.println(F("Mantenimiento Activado"));
              Console.print(F("==================================\n"));
              Console.print(F("==================================\n"));
              digitalWrite(LED_BUILTIN, LOW);
              delay(2000);
              Process Service;
  Service.runShellCommand(F("sudo python /root/service.py"));
  Bridge.get("statusBridge",lbuffer,2);
  variable = atoi(lbuffer);
              //loop();
               
                }//else{
                  //Console.println("else");
                  //digitalWrite(LED_BUILTIN, HIGH);
              //  }
}
void consola(){
  time_check();
  Console.print(F("==================================\n"));
    Console.println(F("Consola de Servicio"));
    Console.print(F("==================================\n"));
    delay(1000);
char readConsole = Console.read();
    do{

if (Console.available() > 0) {
    char readConsole = Console.read();
 
                        if (readConsole == '\n') {

                                      if (name == "cls" ) {
                                        clearAndHome();
                                        name = "";
                                        readConsole = "";
                                      }
                                      
                                      if (name == "quit" ) {
                                                    name = "";
                                                    readConsole = "";                      
                                                    loop(); 
                                      }
                                      if (name == "reboot" ) {
                                        clearAndHome();
                                        Process reboot;
                                        reboot.runShellCommand(F("reboot")); 
                                      }
                                      if (name == "reset" ) {
                                        Process resett;
                                        resett.runShellCommand(F("reset-mcu")); 
                                      }
                                     
                                      if (name == "scann" ) {
                                        scann(); 
                                        name = "";
                                        readConsole = ""; 
                                      }
                                        if (name == "exit" ) {
                                                    name = "";
                                                    readConsole = "";                      
                                                    loop();  
                                      }                               
                                      if (name == "time" ) {
                                        time_check();
                                        name = "";
                                        readConsole = "";  
                                      }
                                      if (name == "email" ) {
                                              deviceEmail = 5;
                                              sentMail();
                                              name = "";
                                              readConsole = "";
                                           }
                                      if (name == "service" ) {
                                               serviceTime();
                                               name = "";
                                               readConsole = "";
                                           }                                     
                                      if (name == "realtime"){
                                            name = "";
                                            readConsole = "";  
                                            clear();
                                            home();                               
                                       
                                       do{
                                        typeSensor = Access;
                                        numPto = 6;
                                        startPto = 0;
                                        bit_check = bits[1];
                                            list_magnetic();
                                        //delay(250);   
                                        typeSensor = Disarm;
                                        numPto = 8;
                                        startPto = 6;
                                        bit_check = bits[6];
                                        list_magnetic();  
                                        //delay(250);   
                                        typeSensor = Phase;
                                        listADC();                                           
                             
                                            readConsole = Console.read();
                                            home(); 
                                       }while(readConsole != '\n');
                                       clear();
                                       clearAndHome();  
                                        }
                                      if (name == "access"){
                                        typeSensor = Access;
                                        numPto = 6;
                                        startPto = 0;
                                        bit_check = bits[1];
                                        list_magnetic();
                                       name = "";
                                       readConsole = "";
                                       }
                                      if (name == "disarm"){
                                        typeSensor = Disarm;
                                        numPto = 8;
                                        startPto = 6;
                                        bit_check = bits[6];
                                        list_magnetic();
                                       name = "";
                                       readConsole = "";
                                       }
                                      if (name == "phase"){
                                        typeSensor = Phase;
                                        listADC();
                                       name = "";
                                       readConsole = "";
                                       }                                      
                                      if (name != 0){
                                         name = "";
                                       readConsole = "";
                                       }
                                      
                                       
                                }
                                       
                             else {     // if the buffer is empty Cosole.read() returns -1
                                            name += readConsole; // append the read char from Console to the name string
                                            //Console.print(name);
                                          }
                 
                              }

    }while(readConsole != '\n');
}
void sentMail(){
                 Bridge.put("deviceEmail", String(deviceEmail));
                 Process emailAccess;
                 emailAccess.runShellCommand(F("python /root/if_mail.py"));
                 Console.print(F("\n Sent Email from Python...\n"));
                 //for (int i=0;i<5;i++){
                 //Console.print(F(".®"));
                 //delay(1000);
                 //}

}

void postData(){
                 Process inDataSensor;
                 inDataSensor.runShellCommand(F("python /root/postData.py"));
                 Console.print(F("\n Post Data MySQL...\n"));
                 //delay(1000);
}
void processProg(){
                   digitalWrite(LED_BUILTIN, HIGH);  
                   delay(100);                    
                   digitalWrite(LED_BUILTIN, LOW);
                   delay(100); 
              }


void loop()
{
  current(); 
  for (int i=0;i<24;i++){
    delay(500);
    Console.print(F("."));
    digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(500);                       // wait for a second
    digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
                                       // wait for a second
    
  char readConsole = Console.read();
  if(readConsole == '\n'){
                  clear();
                  home();
                  consola();
                      
                }
  }
}



