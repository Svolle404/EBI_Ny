import java.awt.Frame;
import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.SmoothCanvas;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import processing.event.MouseEvent;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;

Robot robot;
data data;
hand hand;
computer computer;
settings settings;
handWindow handW;
menuWindow menuW;
tutorialWindow tutorialW;
settingsWindow settingsW;
keyboardWindow keyboardW;

PImage logo;
PImage checkmark;
PFont light;
PFont medium;

color themePrimary = color(60);
color themeSecondary = color(136);
color themeTertiary = color(98);
color text = color(255);

void setup() {
  logo = loadImage("logo.png");
  light = createFont("/fonts/light.otf", 32);
  medium = createFont("/fonts/medium.otf", 64);
  surface.setVisible(false);
  String[] args = {""};
  settings = new settings();
  settings.load();
  handW = new handWindow();
  menuW = new menuWindow();
  tutorialW = new tutorialWindow();
  settingsW = new settingsWindow();
  keyboardW = new keyboardWindow();
  data = new data();
  hand = new hand();
  computer = new computer();
  for (int i = 0; i < handW.hands.length; i++) {
    handW.hands[i] = loadImage("/images/"+i+".png");
  }
  PApplet.runSketch(args, handW);
  PApplet.runSketch(args, menuW);
  PApplet.runSketch(args, tutorialW);
  PApplet.runSketch(args, settingsW);
  PApplet.runSketch(args, keyboardW);
  try {
    robot = new Robot();
  } 
  catch (Throwable e) {
  }
  tutorialW.getSurface().setVisible(false);
  tutorialW.stop();
  tutorialW.running = false;
  settingsW.getSurface().setVisible(false);
  settingsW.stop();
  settingsW.running = false;
  keyboardW.getSurface().setVisible(false);
  keyboardW.stop();
  keyboardW.running = false;
  Toolkit.getDefaultToolkit().setLockingKeyState(KeyEvent.VK_CAPS_LOCK, false);
}

void draw() {
  data.load();
  hand.pointer();
  computer.interact();
}
