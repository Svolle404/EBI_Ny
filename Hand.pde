class hand {
  // Diverse variabler oprettes.
  int[][] landmarks = new int[5][2];
  boolean move = false;
  boolean leftclick = false;
  boolean rightclick = false;
  boolean scroll = false;
  boolean drag = false;
  float x = 0;
  float y = 0;
  int gesture = 0;

  void pointer() {
    gesture = -1;

    // NEUTRAL - Hvis det første håndtegn registreres bliver gesture sat til 0.
    if (landmarks[1][1] < landmarks[0][1]-60 && landmarks[2][1] < landmarks[0][1]-60 && landmarks[3][1] < landmarks[0][1]-60 && landmarks[4][1] < landmarks[0][1]-40) {
      gesture = 0;
    }

    // POINT - Hvis det andet håndtegn registreres bliver gesture sat til 1, og brugerens cursor følger sine bevægelser.
    if (landmarks[1][1] < landmarks[2][1]-80 && landmarks[1][1] < landmarks[3][1]-80 && landmarks[1][1] < landmarks[4][1]-80) {
      x = lerp(x, landmarks[1][0], 0.1);
      y = lerp(y, landmarks[1][1], 0.1);
      robot.mouseMove(int(x), int(y));
      move = true;
      gesture = 1;
    } else {
      move = false;
    }

    // LEFT CLICK - Hvis det tredje håndtegn registreres bliver gesture sat til 2, og variablen leftclick til true.
    if (dist(landmarks[0][0], landmarks[0][1], landmarks[1][0], landmarks[1][1]) < 80 && landmarks[1][1] > landmarks[2][1] && !move) {
      leftclick = true;
      gesture = 2;
    } else {
      leftclick = false;
      
      // Hvis brugeren ikke viser venstreklik håndtegnet mere bliver en variabel i keyboardW
      // klassen sat til true, for at sige, at tastaturet er klar til at blive trykket på igen.
      keyboardW.keyPressReady = true;
    }

    // RIGHT CLICK - Hvis det fjerde håndtegn registreres bliver gesture sat til 3, og variablen rightclick til true.
    if (dist(landmarks[0][0], landmarks[0][1], landmarks[2][0], landmarks[2][1]) < 80 && landmarks[2][1] > landmarks[1][1] && !move) {
      rightclick = true;
      gesture = 3;
    } else {
      rightclick = false;
    }

    // SCROLL - Hvis det femte håndtegn registreres bliver gesture sat til 4, samt startkoordinatet til musens position gemmes i en variabel i klassen computer.
    if (landmarks[1][1] < landmarks[3][1]-120 && landmarks[1][1] < landmarks[4][1]-120 && landmarks[2][1] < landmarks[3][1]-120 && landmarks[2][1] < landmarks[4][1]-120 && !move) {
      if (!scroll) {
        scroll = true;
        computer.scrollStartY = landmarks[1][1];
      }
      gesture = 4;
    } else {
      scroll = false;
    }

    // CLICK AND DRAG - Hvis det sjette håndtegn registreres bliver gesture sat til 5, musen følger brugerens finger og drag sættes til true.
    if (landmarks[1][1] < landmarks[2][1]-120 && landmarks[1][1] < landmarks[3][1]-120 && landmarks[4][1] < landmarks[2][1]-120 && landmarks[4][1] < landmarks[3][1]-120 && !move) {
      x = lerp(x, landmarks[1][0], 0.1);
      y = lerp(y, landmarks[1][1], 0.1);
      robot.mouseMove(int(x), int(y));
      drag = true;
      gesture = 5;
    } else {
      drag = false;
    }
  }
}
