class settingsWindow extends PApplet {
  boolean running = true;
  boolean visible = true;
  boolean mouseClick = false;
  String[] buttonText = {"Gesture", "Keyboard", "Menu", "Theme"};
  int tab = 0;
  float ballSlide = 0;
  PVector dragStart;

  PSurface initSurface() {
    PSurface pSurface = super.initSurface();
    PSurfaceAWT awtSurface = (PSurfaceAWT) surface;
    SmoothCanvas smoothCanvas = (SmoothCanvas) awtSurface.getNative();
    Frame frame = smoothCanvas.getFrame();
    frame.setUndecorated(true);
    return pSurface;
  }
  void settings() {
    size(960, 480);
  }
  void setup() {
    frameRate(999);
    surface.setAlwaysOnTop(true);
    surface.setTitle("Settings");
    surface.setLocation(displayWidth/2-480, displayHeight/2-240);
    surface.setIcon(logo);
    if (!settings.showGesture) {
      ballSlide = 32;
    }
  }
  void draw() {
    if (running) {
      background(themePrimary);
      textAlign(LEFT, CENTER);
      textFont(light, 32);
      noStroke();
      for (int i = 0; i < 4; i++) {
        if (mouseX > 10 && mouseX < 230 && mouseY > 10+i*(48+10) && mouseY < 10+i*(48+10)+48) {
          if (mouseClick) {
            tab = i+1;
          }
          fill(themeSecondary);
        } else {
          fill(themeTertiary);
        }
        rect(10, 10+i*(48+10), 220, 48, 5);
        fill(text);
        text(buttonText[i], 18, 10+i*(48+10)+24);
      }

      stroke(text);
      strokeWeight(2);
      line(width/4, 10, width/4, height-10);

      if (tab == 1) {
        fill(text);
        text("Show gesture window", width/4+10, 34);
        text("Window position", width/4+10, 92);

        if (dist(mouseX, mouseY, width-29, 34) < 19 || dist(mouseX, mouseY, width-29-32, 34) < 19 || mouseX > width-29-32 && mouseX < width-29 && mouseY > 15 && mouseY < 53) {
          if (mouseClick) {
            settings.showGesture = !settings.showGesture;
            settings.save();
            handW.update();
          }
        }

        strokeWeight(38);
        if (settings.showGesture == true) {
          stroke(themeSecondary);
          ballSlide = lerp(ballSlide, 0, 0.1);
        } else {
          stroke(themeTertiary);
          ballSlide = lerp(ballSlide, 32, 0.1);
        }

        line(width-29, 34, width-29-32, 34);
        strokeWeight(32);
        stroke(text);
        point(width-29-ballSlide, 34);

        noStroke();
        if (mouseX > width/4+55 && mouseX < width/4+55+300 && mouseY > 150 && mouseY < 300) {
          fill(themeSecondary);
          if (mouseClick) {
            settings.gesture = 1;
            settings.save();
            handW.update();
          }
        } else {
          fill(themeTertiary);
        }
        rect(width/4+55, 150, 300, 150, 5);

        if (mouseX > width/4+55+310 && mouseX < width/4+55+310+300 && mouseY > 150 && mouseY < 300) {
          fill(themeSecondary);
          if (mouseClick) {
            settings.gesture = 2;
            settings.save();
            handW.update();
          }
        } else {
          fill(themeTertiary);
        }
        rect(width/4+55+310, 150, 300, 150, 5);

        if (mouseX > width/4+55 && mouseX < width/4+55+300 && mouseY > 310 && mouseY < 460) {
          fill(themeSecondary);
          if (mouseClick) {
            settings.gesture = 3;
            settings.save();
            handW.update();
          }
        } else {
          fill(themeTertiary);
        }
        rect(width/4+55, 310, 300, 150, 5);

        if (mouseX > width/4+55+310 && mouseX < width/4+55+310+300 && mouseY > 310 && mouseY < 460) {
          fill(themeSecondary);
          if (mouseClick) {
            settings.gesture = 4;
            settings.save();
            handW.update();
          }
        } else {
          fill(themeTertiary);
        }
        rect(width/4+55+310, 310, 300, 150, 5);

        fill(text);
        rect(width/4+55+5, 155, 32, 32, 5);
        rect(width/4+55+610-37, 155, 32, 32, 5);
        rect(width/4+55+5, 310+150-37, 32, 32, 5);
        rect(width/4+55+610-37, 310+150-37, 32, 32, 5);

        if (settings.gesture == 1) {
          image(checkmark, width/4+180, 200);
        } else if (settings.gesture == 2) {
          image(checkmark, width/4+490, 200);
        } else if (settings.gesture == 3) {
          image(checkmark, width/4+180, 360);
        } else if (settings.gesture == 4) {
          image(checkmark, width/4+490, 360);
        }
      } else if (tab == 2) {
        fill(text);
        text("Keyboard position", width/4+10, 34);

        noStroke();
        if (mouseX > width/4+200 && mouseX < width/4+500 && mouseY > 92 && mouseY < 242) {
          fill(themeSecondary);
          if (mouseClick) {
            settings.keyboard = 1;
            settings.save();
            keyboardW.update();
          }
        } else {
          fill(themeTertiary);
        }
        rect(width/4+200, 92, 300, 150, 5);

        if (mouseX > width/4+200 && mouseX < width/4+500 && mouseY > 252 && mouseY < 402) {
          fill(themeSecondary);
          if (mouseClick) {
            settings.keyboard = 2;
            settings.save();
            keyboardW.update();
          }
        } else {
          fill(themeTertiary);
        }
        rect(width/4+200, 252, 300, 150, 5);

        fill(text);
        rect(width/4+275, 97, 150, 56, 5);
        rect(width/4+275, 341, 150, 56, 5);

        if (settings.keyboard == 1) {
          image(checkmark, width/4+325, 167);
        } else if (settings.keyboard == 2) {
          image(checkmark, width/4+325, 277);
        }
      } else if (tab == 3) {
        fill(text);
        text("Menu position", width/4+10, 34);

        noStroke();
        if (mouseX > width/4+55 && mouseX < width/4+355 && mouseY > 92 && mouseY < 242) {
          fill(themeSecondary);
          if (mouseClick) {
            settings.menu = 1;
            settings.save();
            menuW.update();
          }
        } else {
          fill(themeTertiary);
        }
        rect(width/4+55, 92, 300, 150, 5);

        if (mouseX > width/4+365 && mouseX < width/4+665 && mouseY > 92 && mouseY < 242) {
          fill(themeSecondary);
          if (mouseClick) {
            settings.menu = 2;
            settings.save();
            menuW.update();
          }
        } else {
          fill(themeTertiary);
        }
        rect(width/4+365, 92, 300, 150, 5);

        fill(text);
        rect(width/4+60, 137, 32, 60, 5);
        rect(width/4+365+263, 137, 32, 60, 5);

        if (settings.menu == 1) {
          image(checkmark, width/4+55+125, 142);
        } else if (settings.menu == 2) {
          image(checkmark, width/4+365+125, 142);
        }
      } else if (tab == 4) {
        fill(text);
        text("Red", width/4+10, 34);
        text("Green", width/4+10, 92);
        text("Blue", width/4+10, 150);

        noStroke();
        fill(themeTertiary);
        rect(width/4+135, 18, 450, 32, 5);
        rect(width/4+135, 76, 450, 32, 5);
        rect(width/4+135, 134, 450, 32, 5);

        float themeR = themePrimary >> 16 & 0xFF;
        float themeG = themePrimary >> 8 & 0xFF;
        float themeB = themePrimary & 0xFF;

        fill(themeSecondary);
        rect(width/4+135, 18, 450*(themeR/255.0), 32, 5);
        rect(width/4+135, 76, 450*(themeG/255.0), 32, 5);
        rect(width/4+135, 134, 450*(themeB/255.0), 32, 5);

        textAlign(RIGHT, CENTER);
        fill(text);
        text(int(themeR), width-10, 34);
        text(int(themeG), width-10, 92);
        text(int(themeB), width-10, 150);

        rect(width/4+135+450*(themeR/255.0)-8, 18, 16, 32, 5);
        rect(width/4+135+450*(themeG/255.0)-8, 76, 16, 32, 5);
        rect(width/4+135+450*(themeB/255.0)-8, 134, 16, 32, 5);

        if (mousePressed && dragStart.x > width/4+110 && dragStart.x < width/4+610 && dragStart.y > 18 && dragStart.y < 50) {
          float varR = (float(mouseX-width/4-135)/450.0)*255;
          themePrimary = color(varR, themeG, themeB);
        }
        if (mousePressed && dragStart.x > width/4+110 && dragStart.x < width/4+610 && dragStart.y > 76 && dragStart.y < 108) {
          float varG = (float(mouseX-width/4-135)/450.0)*255;
          themePrimary = color(themeR, varG, themeB);
        }
        if (mousePressed && dragStart.x > width/4+110 && dragStart.x < width/4+610 && dragStart.y > 134 && dragStart.y < 166) {
          float varB = (float(mouseX-width/4-135)/450.0)*255;
          themePrimary = color(themeR, themeG, varB);
        }

        if (mousePressed) {
          settings.updateTheme();
          settings.save();
        }
      }
      mouseClick = false;
    }
  }
  void mousePressed() {
    mouseClick = true;
    dragStart = new PVector(mouseX, mouseY);
  }
}
