// Biblioteker importeres.
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

// Klasser deklareres.
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

// Diverse globale variabler oprettes.
PImage logo;
PImage checkmark;
PFont light;
PFont medium;
PFont lightLarge;

color themePrimary;
color themeSecondary;
color themeTertiary;
color text;

void setup() {
  logo = loadImage("logo.png");
  light = createFont("/fonts/light.otf", 32);
  lightLarge = createFont("/fonts/light.otf", 64);
  medium = createFont("/fonts/medium.otf", 64);
  
  surface.setVisible(false);
  String[] args = {""};
  
  // Deklarerede klasser konstrueres.
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
  
  // Billeder indlæses fra undermapper.
  for (int i = 0; i < handW.hands.length; i++) {
    handW.hands[i] = loadImage("/images/"+i+".png");
  }
  for (int i = 0; i < tutorialW.handsHD.length; i++) {
    tutorialW.handsHD[i] = loadImage("/images/hd/"+i+".png");
  }
  
  // Fem af klasserne bliver kørt i deres egne PApplets.
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
  
  // Hvis det er første gang en bruger starter programmet op bliver tutorialen vist som det første.
  if (!settings.returningUser) {
    settings.returningUser = true;
    settings.save();
  } else {
    tutorialW.getSurface().setVisible(false);
    tutorialW.stop();
    tutorialW.running = false;
  }
  
  // To klasser/vinduer settings og keyboard bliver slået fra/skjult ved programmets opstart.
  settingsW.getSurface().setVisible(false);
  settingsW.stop();
  settingsW.running = false;
  keyboardW.getSurface().setVisible(false);
  keyboardW.stop();
  keyboardW.running = false;
  
  // Caps lock bliver slået fra.
  Toolkit.getDefaultToolkit().setLockingKeyState(KeyEvent.VK_CAPS_LOCK, false);
}

void draw() {
  // Klasserne data, hand og computer opdateres hvert frame.
  data.load();
  hand.pointer();
  computer.interact();
}
