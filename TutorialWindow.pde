class tutorialWindow extends PApplet {
  boolean running = true;
  boolean visible = true;

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
    surface.setLocation(displayWidth/2-480, displayHeight/2-240);
    surface.setIcon(logo);
  }
  void draw() {
    if (running) {
      background(themePrimary);

      stroke(text);
      strokeWeight(2);
      line(width/2, 10, width/2, height-10);
    }
  }
}
