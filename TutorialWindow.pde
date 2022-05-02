class tutorialWindow extends PApplet {
  PImage[] handsHD = new PImage[6];
  boolean running = true;
  boolean visible = true;
  boolean mouseClick = false;
  int step = 0;
  int time = 0;
  int startTime = 0;
  int timeTemp = 0;
  int counter = 0;
  boolean ready = true;
  float progress = 0;

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
    surface.setTitle("Tutorial");
    surface.setLocation(displayWidth/2-480, displayHeight/2-240);
    surface.setIcon(logo);
  }
  void draw() {
    if (running) {
      background(themePrimary);

      stroke(text);
      strokeWeight(2);
      line(width/2, 10, width/2, height-10);

      strokeWeight(16);
      for (int i = 0; i < 6; i++) {
        if (i == step) {
          stroke(themeSecondary);
        } else {
          stroke(themeTertiary);
        }
        point(width/4-2.5*30+i*30, height-height/6);
      }

      if (step == 0) {
        fill(text);
        textAlign(CENTER, CENTER);
        textFont(medium, 64);
        text("Neutral", width/4, height/5);
        image(handsHD[0], width/4-150, height/2-150, 300, 300);

        textAlign(LEFT, TOP);
        textFont(light, 32);
        text("The neutral position is used to make sure the program doesn't register unwanted inputs. Try try doing the neutral gesture for 10 seconds.", width/2+10, 10, 460, 460);

        if (hand.gesture == 0 && ready) {
          startTime = millis();
          ready = false;
        }

        if (hand.gesture != 0 && !ready) {
          ready = true;
        }

        if (hand.gesture == 0) {
          int timeTemp = millis()-startTime;
          time += timeTemp;
          startTime = millis();
        }

        noStroke();
        fill(themeTertiary);
        rect(width/2+60, height-height/3, 360, 48, 5);

        progress = 360*(float(time)/10000.0);
        progress = constrain(progress, 0, 360);

        fill(themeSecondary);
        rect(width/2+60, height-height/3, progress, 48, 5);
      } else if (step == 1) {
        fill(text);
        textAlign(CENTER, CENTER);
        textFont(medium, 64);
        text("Point", width/4, height/5);
        image(handsHD[1], width/4-150, height/2-150, 300, 300);

        textAlign(LEFT, TOP);
        textFont(light, 32);
        text("To move the cursor you just have to raise your pointer finger. The cursor will automatically go to the tip of your finger. Try moving the cursor around.", width/2+10, 10, 460, 460);

        if (hand.gesture == 1) {
          progress += sqrt(sq(hand.landmarks[1][0]-data.px)+sq(hand.landmarks[1][1]-data.py));
        }

        noStroke();
        fill(themeTertiary);
        rect(width/2+60, height-height/3, 360, 48, 5);

        progress = constrain(progress, 0, 50000);

        fill(themeSecondary);
        rect(width/2+60, height-height/3, (progress/50000.0)*360, 48, 5);
      } else if (step == 2) {
        fill(text);
        textAlign(CENTER, CENTER);
        textFont(medium, 64);
        text("Left click", width/4, height/5);
        image(handsHD[2], width/4-150, height/2-150, 300, 300);

        textAlign(LEFT, TOP);
        textFont(light, 32);
        text("To execute a left click tap the tip of your thumb with your index finger. Slow taps are recommended for accurate detection. Try clicking on the buttons below.", width/2+10, 10, 460, 460);

        if (hand.gesture == 2 && ready) {
          startTime = millis();
          ready = false;
        }

        if (hand.gesture != 2 && !ready) {
          ready = true;
        }

        noStroke();
        if (mouseX > width-width/4-190 && mouseX < width-width/4-70 && mouseY > height-height/2.5 && mouseY < height-height/2.5+120) {
          fill(themeSecondary);
          if (mouseClick) {
            counter --;
          }
        } else {
          fill(themeTertiary);
        }
        rect(width-width/4-190, height-height/2.5, 120, 120, 5);

        if (mouseX > width-width/4+70 && mouseX < width-width/4+190 && mouseY > height-height/2.5 && mouseY < height-height/2.5+120) {
          fill(themeSecondary);
          if (mouseClick) {
            counter ++;
          }
        } else {
          fill(themeTertiary);
        }
        rect(width-width/4+70, height-height/2.5, 120, 120, 5);

        fill(255);
        textAlign(CENTER, CENTER);
        textFont(lightLarge, 64);
        text("-", width-width/4-130, height-height/2.5+60);
        text(counter, width-width/4, height-height/2.5+60);
        text("+", width-width/4+130, height-height/2.5+60);
      } else if (step == 3) {
        fill(text);
        textAlign(CENTER, CENTER);
        textFont(medium, 64);
        text("Right click", width/4, height/5);
        image(handsHD[3], width/4-150, height/2-150, 300, 300);

        textAlign(LEFT, TOP);
        textFont(light, 32);
        text("... Slow taps are recommended for accurate detection.", width/2+10, 10, 460, 460);
      } else if (step == 4) {
        fill(text);
        textAlign(CENTER, CENTER);
        textFont(medium, 64);
        text("Scroll", width/4, height/5);
        image(handsHD[4], width/4-150, height/2-150, 300, 300);

        textAlign(LEFT, TOP);
        textFont(light, 32);
        text("... Slow taps are recommended for accurate detection.", width/2+10, 10, 460, 460);
      } else if (step == 5) {
        fill(text);
        textAlign(CENTER, CENTER);
        textFont(medium, 64);
        text("Click and drag", width/4, height/5);
        image(handsHD[5], width/4-150, height/2-150, 300, 300);

        textAlign(LEFT, TOP);
        textFont(light, 32);
        text("... Slow taps are recommended for accurate detection.", width/2+10, 10, 460, 460);
      }

      noStroke();
      if (mouseX > width/2+10 && mouseX < width/2+154 && mouseY > height-58 && mouseY < height-10) {
        fill(themeSecondary);
        if (mouseClick) {
          step --;
          if (step < 0) {
            step = 5;
          }
          time = 0;
          progress = 0;
          counter = 0;
        }
      } else {
        fill(themeTertiary);
      }
      rect(width/2+10, height-58, 144, 48, 5);

      if (mouseX > width-154 && mouseX < width-10 && mouseY > height-58 && mouseY < height-10) {
        fill(themeSecondary);
        if (mouseClick) {
          step = (step+1) % 6;
          time = 0;
          progress = 0;
          counter = 0;
        }
      } else {
        fill(themeTertiary);
      }
      rect(width-154, height-58, 144, 48, 5);


      fill(text);
      textFont(light, 32);
      textAlign(CENTER, CENTER);
      text("Back", width/2+82, height-34);
      text("Next", width-82, height-34);
    }
    mouseClick = false;
  }
  void mousePressed() {
    mouseClick = true;
  }
}
