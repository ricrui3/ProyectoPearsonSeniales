// Processing Code for Example 1
import processing.serial.*;

Serial arduinoPort;
IntList audio1;
IntList audio2;
int numeroDeMuestras = 1200;
int countAudio1 = 0;
int countAudio2 = 0;
int a1ButX, a1ButY;
int a2ButX, a2ButY;
int a1ButW = 400;
int a1ButH = 50;
int a2ButW = 400;
int a2ButH = 50;
boolean a1ButtonOver = false;
boolean a2ButtonOver = false;
boolean leyendoA1 = false;
boolean leyendoA2 = false;
int tamanioTexto = 30;
String tituloProyecto = "Sistema de adquisición de audio";
String stringButton1 = "Presione aqui para tomar la muestra 1";
String stringButton2 = "Presione aqui para tomar la muestra 2";

void setup()
{
  //------Inicializacion de variables-----
  PImage img;
  img = loadImage("smallOmnisphere1.png");
  audio1 = new IntList();
  audio2 = new IntList();
  a1ButX = a2ButX = 200;
  a1ButY = 550;
  a2ButY = 650;
  //--------------------------------------

  //------Interfaz------------------------
  size(800, 800);
  background(img);
  noStroke();
  //--------------------------------------

  println(Serial.list());
  arduinoPort = new Serial(this, Serial.list()[0], 9600);
  arduinoPort.bufferUntil('\n');
}

void draw()
{
  update(mouseX, mouseY);

  fill(255, 255, 255);
  textSize(50);
  textAlign(CENTER);
  text(tituloProyecto, 50, 40, 700, 200);

  fill(83, 208, 180);
  rect(a1ButX, a1ButY, a1ButW, a1ButH);
  fill(255, 255, 255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(stringButton1, a1ButX, a1ButY, a1ButW, a1ButH);

  fill(83, 208, 180);
  rect(a2ButX, a2ButY, a2ButW, a2ButH);
  fill(255, 255, 255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(stringButton2, a2ButX, a2ButY, a2ButW, a2ButH);
}

void update(int x, int y) {
  if ( overA1Button(a1ButX, a1ButY, a1ButW, a1ButH) ) {
    a1ButtonOver = true;
    a2ButtonOver = false;
  } else if ( overA2Button(a2ButX, a2ButY, a2ButW, a2ButH) ) {
    a2ButtonOver = true;
    a1ButtonOver = false;
  } else {
    a1ButtonOver = a2ButtonOver = false;
  }
}

void mousePressed() {
  if (a1ButtonOver) {
    leyendoA1 = true;
    leyendoA2 = false;
    stringButton1 = "Leyendo 1eras muestras";
  }
  if (a2ButtonOver) {
    stringButton2 = "Leyendo 2das muestras";
    leyendoA1 = false;
    leyendoA2 = true;
  }
}

boolean overA1Button(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overA2Button(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

//void muestras1() {
//  println("muestras1");
//  int muestra, mapeo;
//  for (int i = 0; i < numeroDeMuestras; i++) {
//    if (arduinoPort.available() > 0) {
//      muestra = arduinoPort.read();
//      //mapeo = map(muestra, 0, 1023, 0, 575);
//    println(muestra);
//    audio1.append(muestra);
//    }
//    else{
//      i--;
//    }
//  } 
//  stringButton1 = "LEIDO";
//}

//void muestras2() {
//  println("muestras2");
//  for (int i = 0; i < numeroDeMuestras; i++) {
//    audio1.append(int(arduinoPort.readStringUntil('\n')));
//  }
//  stringButton2 = "LEIDO";
//}

void serialEvent(Serial arduinoPort)
{
  String rawInput = arduinoPort.readStringUntil('\n');
  int rawVal = int(trim(rawInput));

  if (leyendoA1 == true) {
    audio1.append(rawVal);
  }
  if (leyendoA2 == true) {
    audio2.append(rawVal);
  }
  countAudio1++;
  //if (leyendoA1 == true) {
  //  println(rawVal + " Numero de muestra audio 1: " + countAudio1);
  //}
  //if (leyendoA2 == true) {
  //  println(rawVal + " Numero de muestra audio 2: " + countAudio1);
  //}
  if (countAudio1 == numeroDeMuestras - 1) {
    //println("leyendoA1 " + leyendoA1 + " leyendoA2 " + leyendoA2);
    countAudio1 = 0;
    if (leyendoA1 == true) {
      stringButton1 = "LEIDO";
      leyendoA1 = false;
    }
    if (leyendoA2 == true) {
      stringButton2 = "LEIDO";
      leyendoA2 = false;
    }
  }
}