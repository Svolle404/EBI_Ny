class tutorialWindow extends PApplet {
  // Diverse variabler oprettes.
  PImage[] handsHD = new PImage[6];
  boolean running = true;
  boolean visible = true;
  boolean mouseClick = false;
  int step = 0;
  int time = 0;
  int startTime = 0;
  int timeTemp = 0;
  int counter = 0;
  int scrollCounter = 0;
  boolean ready = false;
  float progress = 0;
  PVector boxPos = new PVector(720, 316);
  boolean follow = false;

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

        // Hvis brugeren viser det neutrale h??ndtegn begynder programmet at t??lle, hvor l??nge h??ndtegnet er vist.
        if (hand.gesture == 0) {
          int timeTemp = millis()-startTime;
          time += timeTemp;
          startTime = millis();
        }

        noStroke();
        fill(themeTertiary);
        rect(width/2+60, height-height/3, 360, 48, 5);

        // Progressbarens l??ngde opdateres.
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

        // Hvis brugeren viser h??ndtegnet der flytter musen, s?? t??ller programmet hvor mange pixels man har flyttet musen.
        if (hand.gesture == 1) {
          progress += sqrt(sq(hand.landmarks[1][0]-data.px)+sq(hand.landmarks[1][1]-data.py));
        }

        noStroke();
        fill(themeTertiary);
        rect(width/2+60, height-height/3, 360, 48, 5);

        // Variablen begr??nses, s?? l??ngden af baren ikke bare forts??tter med at vokse.
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
            // Hvis brugeren trykker p?? minus tr??kkes der 1 fra counter variablen.
            counter --;
          }
        } else {
          fill(themeTertiary);
        }
        rect(width-width/4-190, height-height/2.5, 120, 120, 5);

        if (mouseX > width-width/4+70 && mouseX < width-width/4+190 && mouseY > height-height/2.5 && mouseY < height-height/2.5+120) {
          fill(themeSecondary);
          if (mouseClick) {
            // Hvis brugeren trykker p?? plus l??gges der 1 til counter variablen.
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
        text("Right clicking is basically the same except you tap the tip of your thumb with your middle finger instead. You can interact with the buttons below by right clicking too.", width/2+10, 10, 460, 460);

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
            // Hvis brugeren trykker p?? minus tr??kkes der 1 fra counter variablen.
            counter --;
          }
        } else {
          fill(themeTertiary);
        }
        rect(width-width/4-190, height-height/2.5, 120, 120, 5);

        if (mouseX > width-width/4+70 && mouseX < width-width/4+190 && mouseY > height-height/2.5 && mouseY < height-height/2.5+120) {
          fill(themeSecondary);
          if (mouseClick) {
            // Hvis brugeren trykker p?? plus l??gges der 1 til counter variablen.
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
      } else if (step == 4) {
        fill(text);
        textAlign(CENTER, CENTER);
        textFont(medium, 64);
        text("Scroll", width/4, height/5);
        image(handsHD[4], width/4-150, height/2-150, 300, 300);

        textAlign(LEFT, TOP);
        textFont(light, 32);
        text("To scroll, raise your pointer and middle finger and lower your ring and pinky finger. While doing this, move your hand up to scroll up or down to scroll down. Try changing the number below by scrolling.", width/2+10, 10, 460, 460);

        fill(255);
        textAlign(CENTER, CENTER);
        textFont(lightLarge, 64);
        text(scrollCounter, width-width/4, height-height/2.5+60);
      } else if (step == 5) {
        fill(text);
        textAlign(CENTER, CENTER);
        textFont(medium, 64);
        text("Click and drag", width/4, height/5);
        image(handsHD[5], width/4-150, height/2-150, 300, 300);

        textAlign(LEFT, TOP);
        textFont(light, 32);
        text("To click and drag you have to raise your pointer and pinky finger, and lower your ring and middle finger. Try dragging the box below around.", width/2+10, 10, 460, 460);

        noStroke();
        fill(themeTertiary);
        rect(width/2+10, height-260, 460, 192, 5);

        // Kassens koordinats??t bliver sat til musens koordinats??t, hvis brugeren trykker holder musen nede, og hvis follow er true.
        if (mousePressed && follow) {
          boxPos.set(mouseX, mouseY);
        }

        boxPos.x = constrain(boxPos.x, width/2+60, width-60);
        boxPos.y = constrain(boxPos.y, height-210, 362);

        fill(text);
        rect(boxPos.x-50, boxPos.y-50, 100, 100, 5);
      }

      noStroke();
      if (mouseX > width/2+10 && mouseX < width/2+154 && mouseY > height-58 && mouseY < height-10) {
        fill(themeSecondary);
        if (mouseClick) {
          // N??r man g??r frem eller tilbage i tutorialen bliver alle variabler nulstillet.
          step --;
          if (step < 0) {
            step = 5;
          }
          time = 0;
          progress = 0;
          counter = 0;
          scrollCounter = 0;
          ready = false;
          startTime = millis();
          boxPos = new PVector(720, 316);
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
          ready = false;
          startTime = millis();
          boxPos = new PVector(720, 316);
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
  void mouseWheel(MouseEvent scroll) {
    // Hvis man scroller bliver scrollCounter variablen opdateret.
    float s = scroll.getCount();
    scrollCounter -= s;
  }
  void mousePressed() {
    mouseClick = true;
    
    // Hvis man klikker inden for kassens rammer bliver follow sat til true.
    if (mouseX > boxPos.x-50 && mouseX < boxPos.x+50 && mouseY > boxPos.y-50 && mouseY < boxPos.y+50) {
      follow = true;
    }
  }
  void mouseReleased() {
    // N??r man ikke klikker mere bliver follow sat til false.
    follow = false;
  }
}
