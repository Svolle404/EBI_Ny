class handWindow extends PApplet {
  // Diverse variabler oprettes.
  PImage[] hands = new PImage[6];
  boolean running = true;

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
    size(200, 200);
  }
  void setup() {
    frameRate(999);
    surface.setAlwaysOnTop(true);
    surface.setTitle("Gesture");

    // Hvis brugeren har slået dette vindue fra bliver det slukket/skjult ved programmets opstart. Ellers
    // bliver vinduets position sat til hvad end brugeren har valgt.
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

    // Hvis integeren gesture i klassen hand er større end 0 bliver det tilsvarende billede i et array vist.
    if (hand.gesture >= 0) {
      image(hands[hand.gesture], 0, 0);
    }
  }
  
  // Metoden update kaldes hvis brugeren har ændret på relevante variabler for denne klasse, herunder position og tilstand.
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
