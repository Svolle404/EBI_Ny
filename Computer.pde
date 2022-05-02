class computer {
  boolean leftclickReady = false;
  boolean rightclickReady = false;
  boolean dragReady = false;
  int scrollStartY = 0;

  void interact() {
    if (hand.leftclick && leftclickReady) {
      if (!keyboardW.mouseOver) {
        robot.mousePress(InputEvent.BUTTON1_MASK);
      }
      leftclickReady = false;
      println("Left click "+millis());
    }
    if (!hand.leftclick && !leftclickReady) {
      robot.mouseRelease(InputEvent.BUTTON1_MASK);
      leftclickReady = true;
    }

    if (hand.rightclick && rightclickReady) {
      robot.mousePress(InputEvent.BUTTON3_MASK);
      rightclickReady = false;
      println("Right click "+millis());
    }
    if (!hand.rightclick && !rightclickReady) {
      robot.mouseRelease(InputEvent.BUTTON3_MASK);
      rightclickReady = true;
    }

    if (hand.scroll) {
      if (hand.landmarks[1][1] < scrollStartY-40) {
        robot.mouseWheel(-1);
        scrollStartY = hand.landmarks[1][1];
      }
      if (hand.landmarks[1][1] > scrollStartY+40) {
        robot.mouseWheel(1);
        scrollStartY = hand.landmarks[1][1];
      }
    }

    if (hand.drag && dragReady) {
      robot.mousePress(InputEvent.BUTTON1_MASK);
      dragReady = false;
    } 
    if (!hand.drag && !dragReady) {
      robot.mouseRelease(InputEvent.BUTTON1_MASK);
      dragReady = true;
    }
  }
}
