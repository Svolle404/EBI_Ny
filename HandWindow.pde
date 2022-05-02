class handWindow extends PApplet {
  PImage[] hands = new PImage[6];
  boolean running = true;

  PSurface initSurface() {
    PSurface pSurface = super.initSurface();
    PSurfaceAWT awtSurface = (PSurfaceAWT) surface;
    SmoothCanvas smoothCanvas = (SmoothCanvas) awtSurface.getNative();
    Frame frame = smoothCanvas.getFrame();
    frame.setUndecorated(true);
    return pSurface;
  }
  void settings() {
    size(200, 200);
  }
  void setup() {
    frameRate(999);
    surface.setAlwaysOnTop(true);
    surface.setTitle("Gesture");
    if (settings.showGesture == false) {
      handW.getSurface().setVisible(false);
      handW.stop();
      handW.running = false;
    } else if (settings.gesture == 1) {
      surface.setLocation(5, 5);
    } else if (settings.gesture == 2) {
      surface.setLocation(displayWidth-205, 5);
    } else if (settings.gesture == 3) {
      surface.setLocation(5, displayHeight-205);
    } else if (settings.gesture == 4) {
      surface.setLocation(displayWidth-205, displayHeight-205);
    } 
    surface.setIcon(logo);
  }
  void draw() {
    background(themePrimary);
    if (hand.gesture >= 0) {
      image(hands[hand.gesture], 0, 0);
    }
  }
  void update() {
    if (settings.showGesture == false) {
      handW.getSurface().setVisible(false);
      handW.stop();
      handW.running = false;
    } else {
      handW.getSurface().setVisible(true);
      handW.start();
      handW.running = true;
    }
    if (settings.gesture == 1) {
      surface.setLocation(5, 5);
    } else if (settings.gesture == 2) {
      surface.setLocation(displayWidth-205, 5);
    } else if (settings.gesture == 3) {
      surface.setLocation(5, displayHeight-205);
    } else if (settings.gesture == 4) {
      surface.setLocation(displayWidth-205, displayHeight-205);
    }
  }
}
