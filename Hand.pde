class hand {
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
    gesture = 0;

    if (landmarks[1][1] < landmarks[2][1]-80 && landmarks[1][1] < landmarks[3][1]-80 && landmarks[1][1] < landmarks[4][1]-80) {
      x = lerp(x, landmarks[1][0], 0.1);
      y = lerp(y, landmarks[1][1], 0.1);
      robot.mouseMove(int(x), int(y));
      move = true;
      gesture = 1;
    } else {
      move = false;
    }

    if (dist(landmarks[0][0], landmarks[0][1], landmarks[1][0], landmarks[1][1]) < 80 && landmarks[1][1] > landmarks[2][1] && !move) {
      leftclick = true;
      gesture = 2;
    } else {
      leftclick = false;
      keyboardW.keyPressReady = true;
    }

    if (dist(landmarks[0][0], landmarks[0][1], landmarks[2][0], landmarks[2][1]) < 80 && landmarks[2][1] > landmarks[1][1] && !move) {
      rightclick = true;
      gesture = 3;
    } else {
      rightclick = false;
    }

    if (landmarks[1][1] < landmarks[3][1]-120 && landmarks[1][1] < landmarks[4][1]-120 && landmarks[2][1] < landmarks[3][1]-120 && landmarks[2][1] < landmarks[4][1]-120 && !move) {
      if (!scroll) {
        scroll = true;
        computer.scrollStartY = landmarks[1][1];
      }
      gesture = 4;
    } else {
      scroll = false;
    }

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
