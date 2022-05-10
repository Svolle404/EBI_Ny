class settings {
  // Diverse variabler oprettes.
  int gesture = 0;
  boolean showGesture = true;
  int keyboard = 0;
  int menu = 0;
  boolean returningUser = false;
  int r = 60;
  int g = 60;
  int b = 60;

  void load() {
    // De enkelte linjer i tekstfilen settings.txt bliver indlæst i et string array, hvorefter værdierne fordeles på diverse variabler.
    String[] data = loadStrings("/settings.txt");
    gesture = int(data[0]);
    showGesture = boolean(int(data[1]));
    keyboard = int(data[2]);
    menu = int(data[3]);
    returningUser = boolean(int(data[4]));
    r = int(data[5]);
    g = int(data[6]);
    b = int(data[7]);
    themePrimary = color(r, g, b);
    
    // Programmets sekundære og tertiære farve bliver oprettet alt efter hvor lys den primære farve er.
    if (brightness(themePrimary) > 160) {
      text = color(0);
      checkmark = loadImage("checkmarkBlackSmall.png");
      themeSecondary = color(r*0.6, g*0.6, b*0.6);
      themeTertiary = color(r*0.8, g*0.8, b*0.8);
    } else {
      text = color(255);
      checkmark = loadImage("checkmarkWhiteSmall.png");
      float extra = 40-brightness(themePrimary);
      extra = constrain(extra, 0, 60);
      themeSecondary = color((r+40)*1.4, (g+40)*1.4, (b+40)*1.4);
      themeTertiary = color((r+20)*1.2, (g+20)*1.2, (b+20)*1.2);
    }
  }
  
  // Hvis der ændres på programmets indstillinger bliver metoden saven kaldt med det samme for at gemme ændringerne.
  void save() {
    int themeR = themePrimary >> 16 & 0xFF;
    int themeG = themePrimary >> 8 & 0xFF;
    int themeB = themePrimary & 0xFF;
    String variables = gesture+" "+int(showGesture)+" "+keyboard+" "+menu+" "+int(returningUser)+" "+themeR+" "+themeG+" "+themeB;
    String[] data = split(variables, ' ');
    saveStrings("settings.txt", data);
  }
  
  // Hvis programmets primære farve ændres bliver den sekundære og tertiære farve opdateret med metoden updateTheme.
  void updateTheme() {
    float themeR = themePrimary >> 16 & 0xFF;
    float themeG = themePrimary >> 8 & 0xFF;
    float themeB = themePrimary & 0xFF;

    if (brightness(themePrimary) > 160) {
      text = color(0);
      checkmark = loadImage("checkmarkBlackSmall.png");
      themeSecondary = color(themeR*0.6, themeG*0.6, themeB*0.6);
      themeTertiary = color(themeR*0.8, themeG*0.8, themeB*0.8);
    } else {
      text = color(255);
      checkmark = loadImage("checkmarkWhiteSmall.png");
      float extra = 40-brightness(themePrimary);
      extra = constrain(extra, 0, 60);
      themeSecondary = color((themeR+40)*1.4, (themeG+40)*1.4, (themeB+40)*1.4);
      themeTertiary = color((themeR+20)*1.2, (themeG+20)*1.2, (themeB+20)*1.2);
    }
  }
}
