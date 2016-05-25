// Processing Code for Example 1
import processing.serial.*;

Serial arduinoPort;
IntList audio1;
IntList audio2;
int a1ButX, a1ButY;
int a2ButX, a2ButY;
int a1ButW = 400;
int a1ButH = 50;
int a2ButW = 400;
int a2ButH = 50;
boolean a1ButtonOver = false;
boolean a2ButtonOver = false;

void setup()
{
  //------Inicializacion de variables-----
  PImage img;
  img = loadImage("smallOmnisphere.png");
  audio1 = new IntList();
  audio1 = new IntList();
  a1ButX = a2ButX = 200;
  a1ButY = 130;
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

  rect(a1ButX, a1ButY, a1ButW, a1ButH);
  fill(234, 22, 54);
  rect(a2ButX, a2ButY, a2ButW, a2ButH);
  fill(234, 220, 54);
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
    muestras1();
  }
  if (a2ButtonOver) {
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
  fill(0,0,0);
}

void muestras2() {
  println("muestras2");
  fill(0,0,0);
}