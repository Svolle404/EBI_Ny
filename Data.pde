class data {
  // Diverse variabler oprettes.
  int time = 0;
  int px = 0;
  int py = 0;

  void load() {
    // De enkelte linjer i tekstfilen data.txt bliver indlæst i et string array.
    String[] data = loadStrings("C:/Users/Berith Svoldgade/PycharmProjects/pythonProject/data.txt");
    
    // Hvis arrayet har en længde på mere end 4 - altså hvis der er koordinatsæt til alle fingre - så
    // bliver de fordelt i fem individuelle integer arrays; et til hver finger.
    if (data.length > 4) {
      int[] finger1 = int(split(data[0], ' '));
      int[] finger2 = int(split(data[1], ' '));
      int[] finger3 = int(split(data[2], ' '));
      int[] finger4 = int(split(data[3], ' '));
      int[] finger5 = int(split(data[4], ' '));

      if (millis() > time+100) {
        time = millis();
        px = hand.landmarks[1][0];
        py = hand.landmarks[1][1];
      }

      // Koordinatsættene bliver sendt over til et todimensionelt integer array i klassen hand.
      hand.landmarks[0][0] = finger1[0];
      hand.landmarks[0][1] = finger1[1];
      hand.landmarks[1][0] = finger2[0];
      hand.landmarks[1][1] = finger2[1];
      hand.landmarks[2][0] = finger3[0];
      hand.landmarks[2][1] = finger3[1];
      hand.landmarks[3][0] = finger4[0];
      hand.landmarks[3][1] = finger4[1];
      hand.landmarks[4][0] = finger5[0];
      hand.landmarks[4][1] = finger5[1];
    }
  }
}
