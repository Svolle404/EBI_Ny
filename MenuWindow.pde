class menuWindow extends PApplet {
  // Diverse variabler oprettes.
  boolean mouseOver = false;
  float xPos = 0;
  float alpha = 0;
  int xPosP = 0;
  String[] buttonText = {"Exit", "Tutorial", "Settings", "Keyboard"};
  boolean mouseClick = false;

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
    size(256, 512);
  }
  void setup() {
    frameRate(999);
    surface.setAlwaysOnTop(true);
    surface.setTitle("Menu");

    // Menuens position sættes til hvad end brugeren har valgt.
    if (settings.menu == 1) {
      xPos = -236;
    } else if (settings.menu == 2) {
      xPos = displayWidth-20;
    }
    surface.setLocation(int(xPos), displayHeight/2-256);
    surface.setIcon(logo);
  }
  void draw() {
    background(themePrimary);
    textAlign(CENTER, CENTER);

    textFont(medium, 64);
    fill(text);
    text("Menu", 128, 71);

    noStroke();
    // Menuens fire knapper tegnes ved hjælp af en for-løkke.
    for (int i = 0; i < 4; i++) {
      if (mouseX > 10 && mouseX < width-10 && mouseY > height-10-i*90-80 && mouseY < height-10-i*90) {
        // Hver knap "tænder" eller "slukker" for en af de PApplets der kører undtagen den sidste som lukker programmet.
        if (i == 3 && mouseClick) {
          if (keyboardW.running) {
            keyboardW.getSurface().setVisible(false);
            keyboardW.stop();
            keyboardW.running = false;
          } else {
            keyboardW.getSurface().setVisible(true);
            keyboardW.start();
            keyboardW.running = true;
          }
        }
        if (i == 2 && mouseClick) {
          if (settingsW.running) {
            settingsW.getSurface().setVisible(false);
            settingsW.stop();
            settingsW.running = false;
          } else {
            settingsW.getSurface().setVisible(true);
            settingsW.start();
            settingsW.running = true;
            tutorialW.getSurface().setVisible(false);
            tutorialW.stop();
            tutorialW.running = false;
          }
        }
        if (i == 1 && mouseClick) {
          if (tutorialW.running) {
            tutorialW.getSurface().setVisible(false);
            tutorialW.stop();
            tutorialW.running = false;
          } else {
            tutorialW.getSurface().setVisible(true);
            tutorialW.start();
            tutorialW.running = true;
            tutorialW.time = 0;
            tutorialW.step = 0;
            tutorialW.progress = 0;
            tutorialW.scrollCounter = 0;
            tutorialW.counter = 0;
            tutorialW.ready = false;
            tutorialW.startTime = millis();
            tutorialW.boxPos = new PVector(720, 316);
            settingsW.getSurface().setVisible(false);
            settingsW.stop();
            settingsW.running = false;
          }
        }
        if (i == 0 && mouseClick) {
          exit();
        }
        fill(themeSecondary, alpha);
      } else {
        fill(themeTertiary, alpha);
      }
      rect(10, height-10-i*90, 236, -80, 5);
      fill(text);
      textFont(light, 32);
      text(buttonText[i], 128, height-10-i*90-40);
    }

    xPosP = int(xPos);

    // Hvis man holder musen over den lille del af menuen der er synlig, så "udfolder" den sig så man kan se hele menuen.
    if (mouseOver) {
      if (settings.menu == 1) {
        xPos = lerp(xPos, 0, 0.1);
      } else if (settings.menu == 2) {
        xPos = lerp(xPos, displayWidth-256, 0.1);
      }
      alpha = lerp(alpha, 255, 0.025);
    } else {
      if (settings.menu == 1) {
        xPos = lerp(xPos, -236, 0.1);
      } else if (settings.menu == 2) {
        xPos = lerp(xPos, displayWidth-20, 0.1);
      }
      alpha = lerp(alpha, 0, 0.1);
    }

    if (xPosP != int(xPos)) {
      surface.setLocation(int(xPos), displayHeight/2-256);
    }

    mouseClick = false;
  }
  
  // Hvis brugeren ændrer på menuen position bliver metoden update kaldt bagefter for at opdateres menuens position på skærmen.
  void update() {
    if (settings.menu == 1) {
      xPos = -236;
    } else if (settings.menu == 2) {
      xPos = displayWidth-20;
    }
    surface.setLocation(int(xPos), displayHeight/2-256);
  }
  void mouseEntered() {
    mouseOver = true;
  }
  void mouseExited() {
    mouseOver = false;
  }
  void mousePressed() {
    mouseClick = true;
  }
}
