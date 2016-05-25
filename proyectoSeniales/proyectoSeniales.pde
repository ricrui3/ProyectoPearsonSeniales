// Processing Code for Example 1
import processing.serial.*;

Serial arduinoPort;
IntList audio1;
IntList audio2;
int numeroDeMuestras = 500;
int a1ButX, a1ButY;
int a2ButX, a2ButY;
int a1ButW = 400;
int a1ButH = 50;
int a2ButW = 400;
int a2ButH = 50;
boolean a1ButtonOver = false;
boolean a2ButtonOver = false;
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
  audio1 = new IntList();
  a1ButX = a2ButX = 200;
  a1ButY = 550;
  a2ButY = 650;
  //--------------------------------------

  //------Interfaz------------------------
  size(800, 800);
  background(img);
  noStroke();
  //--------------------------------------

  //arduinoPort = new Serial(this, "COM5", 9600);
}

void draw()
{
  update(mouseX, mouseY);
  
  fill(255,255,255);
  textSize(50);
  textAlign(CENTER);
  text(tituloProyecto, 50, 40, 700, 200);

  fill(83, 208, 180);
  rect(a1ButX, a1ButY, a1ButW, a1ButH);
  fill(255,255,255);
  textSize(20);
  textAlign(CENTER,CENTER);
  text(stringButton1, a1ButX, a1ButY, a1ButW, a1ButH);
  
  fill(83, 208, 180);
  rect(a2ButX, a2ButY, a2ButW, a2ButH);
  fill(255,255,255);
  textSize(20);
  textAlign(CENTER,CENTER);
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
    stringButton1 = "Leyendo 1eras muestras";
    muestras1();
  }
  if (a2ButtonOver) {
    stringButton2 = "Leyendo 2das muestras";
    muestras2();
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

void muestras1() {
  println("muestras1");
  for(int i = 0; i < numeroDeMuestras; i++){
    audio1.append(int(arduinoPort.readStringUntil('\n')));
  } 
  stringButton1 = "LEIDO";
}

void muestras2() {
  println("muestras2");
  for(int i = 0; i < numeroDeMuestras; i++){
    audio1.append(int(arduinoPort.readStringUntil('\n')));
  }
  stringButton2 = "LEIDO";
}