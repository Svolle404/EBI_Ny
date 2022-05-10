class keyboardWindow extends PApplet {
  // Diverse variabler oprettes.
  boolean running = true;
  boolean visible = true;
  boolean mouseOver = false;
  float alpha = 0;
  float yPos = 0;
  int yPosP = 0;
  int smallButtonSize = 80;
  String[][] keyboardKeys = {{"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "+", "DELETE"}, {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "Å", "ENTER"}, {"A", "S", "D", "F", "G", "H", "J", "K", "L", "Æ", "Ø"}, {"Z", "X", "C", "V", "B", "N", "M", ",", ".", "-", "CAPS"}};
  int[][] keyDecimalValues = {{49, 50, 51, 52, 53, 54, 55, 56, 57, 48, -5}, {81, 87, 69, 82, 84, 89, 85, 73, 79, 80, -1}, {65, 83, 68, 70, 71, 72, 74, 75, 76, -2, -3}, {90, 88, 67, 86, 66, 78, 77, 44, 46, 45, -4}};
  String[][] mathKeys = {{"7", "8", "9", "÷", "%"}, {"4", "5", "6", "*", "."}, {"1", "2", "3", "-", "("}, {"0", "DEL", "=", "+", ")"}};
  int[][] mathDecimalValues = {{55, 56, 57, -7, -8}, {52, 53, 54, -6, 46}, {49, 50, 51, 45, -1}, {48, -3, -999, -4, -2}};
  boolean keyPressReady = true;
  boolean capslock = false;
  int keyboardMode = 0;

  // Vinduets kanter fjernes.
  PSurface initSurface() {
    PSurface pSurface = super.initSurface();
    PSurfaceAWT awtSurface = (PSurfaceAWT) surface;
    SmoothCanvas smoothCanvas = (SmoothCanvas) awtSurface.getNative();
    Frame frame = smoothCanvas.getFrame();
    frame.setUndecorated(true);
    return pSurface;
  }
  void settings() {
    size(1170, 460);
  }
  void setup() {
    frameRate(999);
    surface.setAlwaysOnTop(true);
    surface.setTitle("Keyboard");
    
    // Tastaturets position sættes til hvad end brugeren har valgt.
    if (settings.keyboard == 1) {
      yPos = -440;
      surface.setLocation(displayWidth/2-585, int(yPos));
    } else if (settings.keyboard == 2) {
      yPos = displayHeight;
      surface.setLocation(displayWidth/2-585, int(yPos));
    }
    surface.setIcon(logo);
  }
  void draw() {
    if (running) {
      background(themePrimary);
      noStroke();
      if (keyboardMode == 0) {
        // En indlejret for-løkke tegner de små taster på tastaturet samt tjekker om brugeren holder musen over dem eller trykker på dem.
        for (int i = 0; i < 11; i++) {
          for (int j = 0; j < 4; j++) {
            if (j == 3 && i == 10) {
            } else {
              if (mouseX > 10+j*0.33333*(smallButtonSize+10)+i*(smallButtonSize+10) && mouseX < 10+j*0.3333*(smallButtonSize+10)+i*(smallButtonSize+10)+smallButtonSize && mouseY > 10+j*(smallButtonSize+10) && mouseY < 10+j*(smallButtonSize+10)+smallButtonSize) {
                fill(themeSecondary, alpha);
                if (hand.gesture == 2 && keyPressReady) {
                  keyPressReady = false;
                  if (keyDecimalValues[j][i] >= 0) {
                    // Hvis en knap bliver trykket på simuleres et tastetryk.
                    robot.keyPress(keyDecimalValues[j][i]);
                    robot.keyRelease(keyDecimalValues[j][i]);
                  } else {
                    // Ved særtilfælde bruges en anden metode til at skrive bogstaverne.
                    if (keyDecimalValues[j][i] == -1) {
                      if (capslock) {
                        specialKey("Å");
                      } else {
                        specialKey("å");
                      }
                    } else if (keyDecimalValues[j][i] == -2) {
                      if (capslock) {
                        specialKey("Æ");
                      } else {
                        specialKey("æ");
                      }
                    } else if (keyDecimalValues[j][i] == -3) {
                      if (capslock) {
                        specialKey("Ø");
                      } else {
                        specialKey("ø");
                      }
                    } else if (keyDecimalValues[j][i] == -4) {
                      robot.keyPress(KeyEvent.VK_ADD);
                      robot.keyRelease(KeyEvent.VK_ADD);
                    }
                  }
                }
              } else {
                fill(themeTertiary, alpha);
              }
              rect(10+j*0.3333*(smallButtonSize+10)+i*(smallButtonSize+10), 10+j*(smallButtonSize+10), smallButtonSize, smallButtonSize, 5);
              fill(text);
              textAlign(CENTER, CENTER);
              textFont(light, 32);
              text(keyboardKeys[j][i], 10+j*0.3333*(smallButtonSize+10)+i*(smallButtonSize+10)+smallButtonSize/2, 10+j*(smallButtonSize+10)+smallButtonSize/2);
            }
          }
        }
        // Alle tasterne med specielle forme tegnes manuelt.
        if (mouseX > 10+11*(smallButtonSize+10) && mouseY < 10+11*(smallButtonSize+10)+smallButtonSize*2 && mouseY > 10 && mouseY < 10+smallButtonSize) {
          fill(themeSecondary, alpha);
          if (hand.gesture == 2 && keyPressReady) {
            keyPressReady = false;
            robot.keyPress(KeyEvent.VK_BACK_SPACE);
            robot.keyRelease(KeyEvent.VK_BACK_SPACE);
          }
        } else {
          fill(themeTertiary, alpha);
        }
        rect(10+11*(smallButtonSize+10), 10, smallButtonSize*2, smallButtonSize, 5);

        if ((mouseX > 10+1*0.33333*(smallButtonSize+10)+11*(smallButtonSize+10) && mouseY < 10+1*0.33333*(smallButtonSize+10)+11*(smallButtonSize+10)+smallButtonSize+smallButtonSize*2*(0.33333)-3.33333 && mouseY > 10+1*(smallButtonSize+10) && mouseY < 10+1*(smallButtonSize+10)+smallButtonSize) || (mouseX > 10+2*0.33333*(smallButtonSize+10)+11*(smallButtonSize+10) && mouseX < 10+2*0.33333*(smallButtonSize+10)+11*(smallButtonSize+10)+smallButtonSize+smallButtonSize/4 && mouseY > 10+2*(smallButtonSize+10)-smallButtonSize*0.5 && mouseY < 10+2*(smallButtonSize+10)-smallButtonSize*0.5+smallButtonSize*1.5)) {
          fill(themeSecondary, alpha);
          if (hand.gesture == 2 && keyPressReady) {
            keyPressReady = false;
            robot.keyPress(KeyEvent.VK_ENTER);
            robot.keyRelease(KeyEvent.VK_ENTER);
          }
        } else {
          fill(themeTertiary, alpha);
        }
        rect(10+1*0.33333*(smallButtonSize+10)+11*(smallButtonSize+10), 10+1*(smallButtonSize+10), smallButtonSize+smallButtonSize*2*(0.33333)-3.33333, smallButtonSize, 5);
        rect(10+2*0.33333*(smallButtonSize+10)+11*(smallButtonSize+10), 10+2*(smallButtonSize+10)-smallButtonSize*0.5, smallButtonSize+smallButtonSize/4, smallButtonSize*1.5, 5);

        if (mouseX > 10+11*(smallButtonSize+10) && mouseY < 10+11*(smallButtonSize+10)+smallButtonSize*2 && mouseY > 10+3*(smallButtonSize+10) && mouseY < 10+3*(smallButtonSize+10)+smallButtonSize) {
          fill(themeSecondary, alpha);
          if (capslock) {
            fill(text, alpha);
          }
          if (hand.gesture == 2 && keyPressReady) {
            keyPressReady = false;
            robot.keyPress(KeyEvent.VK_CAPS_LOCK);
            robot.keyRelease(KeyEvent.VK_CAPS_LOCK);
            capslock = !capslock;
          }
        } else {
          fill(themeTertiary, alpha);
          if (capslock) {
            fill(text, alpha);
          }
        }
        rect(10+11*(smallButtonSize+10), 10+3*(smallButtonSize+10), smallButtonSize*2, smallButtonSize, 5);

        fill(text);
        text(keyboardKeys[0][11], 10+11*(smallButtonSize+10)+smallButtonSize, 10+smallButtonSize/2);
        text(keyboardKeys[1][11], 10+1*0.33333*(smallButtonSize+10)+11*(smallButtonSize+10)+(smallButtonSize+smallButtonSize*2*(0.33333)-3.33333)/2, 10+1*(smallButtonSize+10)+smallButtonSize/2);
        if (capslock) {
          fill(abs(brightness(text)-255));
        }
        text(keyboardKeys[3][10], 10+3*0.3333*(smallButtonSize+10)+10*(smallButtonSize+10)+smallButtonSize, 10+3*(smallButtonSize+10)+smallButtonSize/2);

        if (mouseX > width/4 && mouseX < width-width/4 && mouseY > height-10-smallButtonSize && mouseY < height-10) {
          fill(themeSecondary, alpha);
          if (hand.gesture == 2 && keyPressReady) {
            keyPressReady = false;
            robot.keyPress(KeyEvent.VK_SPACE);
            robot.keyRelease(KeyEvent.VK_SPACE);
          }
        } else {
          fill(themeTertiary, alpha);
        }
        rect(width/4, height-10-smallButtonSize, width/2, smallButtonSize, 5);

        fill(text);
        text("SPACE", width/2, height-10-smallButtonSize/2);
      } else if (keyboardMode == 1) {
        // Matematik tastaturets taster tegnes også med en indlejret for-løkke.
        textAlign(CENTER, CENTER);
        textFont(light, 32);
        for (int i = 0; i < 5; i++) {
          for (int j = 0; j < 4; j++) {
            if (mouseX > width/2-2.5*smallButtonSize-20+i*(smallButtonSize+10) && mouseX < width/2-2.5*smallButtonSize-20+i*(smallButtonSize+10)+smallButtonSize && mouseY > 10+j*(smallButtonSize+10) && mouseY < 10+j*(smallButtonSize+10)+smallButtonSize) {
              fill(themeSecondary, alpha);
              if (hand.gesture == 2 && keyPressReady) {
                keyPressReady = false;
                if (mathDecimalValues[j][i] >= 0) {
                  robot.keyPress(mathDecimalValues[j][i]);
                  robot.keyRelease(mathDecimalValues[j][i]);
                  
                 // Ved særtilfælde bruges der igen en anden metode til at skrive tegnene.
                } else if (mathDecimalValues[j][i] == -1) {
                  specialKey("(");
                } else if (mathDecimalValues[j][i] == -2) {
                  specialKey(")");
                } else if (mathDecimalValues[j][i] == -3) {
                  robot.keyPress(KeyEvent.VK_BACK_SPACE);
                  robot.keyRelease(KeyEvent.VK_BACK_SPACE);
                } else if (mathDecimalValues[j][i] == -4) {
                  specialKey("=");
                } else if (mathDecimalValues[j][i] == -5) {
                  robot.keyPress(KeyEvent.VK_ADD);
                  robot.keyRelease(KeyEvent.VK_ADD);
                } else if (mathDecimalValues[j][i] == -6) {
                  specialKey("*");
                } else if (mathDecimalValues[j][i] == -7) {
                  specialKey("/");
                } else if (mathDecimalValues[j][i] == -8) {
                  specialKey("%");
                }
              }
            } else {
              fill(themeTertiary, alpha);
            }
            rect(width/2-2.5*smallButtonSize-20+i*(smallButtonSize+10), 10+j*(smallButtonSize+10), smallButtonSize, smallButtonSize, 5);
            fill(text);
            text(mathKeys[j][i], width/2-2.5*smallButtonSize-20+i*(smallButtonSize+10)+smallButtonSize/2, 10+j*(smallButtonSize+10)+smallButtonSize/2);
          }
        }

        if (mouseX > width/2-2.5*smallButtonSize-20 && mouseX < width/2-2.5*smallButtonSize-20+440 && mouseY > 370 && mouseY < 450) {
          fill(themeSecondary, alpha);
          if (hand.gesture == 2 && keyPressReady) {
            keyPressReady = false;
            robot.keyPress(KeyEvent.VK_ENTER);
            robot.keyRelease(KeyEvent.VK_ENTER);
          }
        } else {
          fill(themeTertiary);
        }
        rect(width/2-2.5*smallButtonSize-20, 370, 440, smallButtonSize, 5);

        fill(text);
        text("ENTER", width/2, 410);
      }

      if (mouseX > width-width/4+10 && mouseX < width-width/4+10+272.5 && mouseY > height-10-smallButtonSize && mouseY < height-10) {
        fill(themeSecondary, alpha);
        if (hand.gesture == 2 && keyPressReady) {
          keyPressReady = false;
          keyboardMode = (keyboardMode+1) % 2;
        }
      } else {
        fill(themeTertiary, alpha);
      }
      rect(width-width/4+10, height-10-smallButtonSize, 272.5, smallButtonSize, 5);
      fill(text);
      if (keyboardMode == 0) {
        text("MATH", width-width/4+10+136.25, height-10-smallButtonSize/2);
      } else if (keyboardMode == 1) {
        text("STANDARD", width-width/4+10+136.25, height-10-smallButtonSize/2);
      }

      yPosP = int(yPos);

      // Hvis musen er over den lille del af tastaturet der stikker ud, så
      // udvider det sig, så man kan se hele tastaturet.
      if (mouseOver) {
        alpha = lerp(alpha, 255, 0.025);
        if (settings.keyboard == 1) {
          yPos = lerp(yPos, 0, 0.1);
        } else if (settings.keyboard == 2) {
          yPos = lerp(yPos, displayHeight-460, 0.1);
        }
      } else {
        alpha = lerp(alpha, 0, 0.1);
        if (settings.keyboard == 1) {
          yPos = lerp(yPos, -440, 0.1);
        } else if (settings.keyboard == 2) {
          yPos = lerp(yPos, displayHeight-20, 0.1);
        }
      }

      if (yPosP != int(yPos)) {
        surface.setLocation(displayWidth/2-585, int(yPos));
      }
    }
  }
  
  // Metoden specialKey bruges til at skrive de tegn, som ikke kan skrives med simulerede tastatryk. Det er
  // i bund og grund bare en kompliceret måde at copy/paste en string.
  void specialKey(String k) {
    Toolkit toolkit = Toolkit.getDefaultToolkit();
    Clipboard clipboard = toolkit.getSystemClipboard();
    StringSelection strSel = new StringSelection(k);
    clipboard.setContents(strSel, null);
    robot.keyPress(KeyEvent.VK_CONTROL);
    robot.keyPress(KeyEvent.VK_V);
    robot.keyRelease(KeyEvent.VK_V);
    robot.keyRelease(KeyEvent.VK_CONTROL);
  }

  // Metoden update kaldes hvis brugeren har ændret på tastaturets position.
  void update() {
    if (settings.keyboard == 1) {
      yPos = -440;
    } else if (settings.keyboard == 2) {
      yPos = displayHeight-20;
    }
    surface.setLocation(displayWidth/2-585, int(yPos));
  }
  void mouseEntered() {
    mouseOver = true;
  }
  void mouseExited() {
    mouseOver = false;
  }
}
