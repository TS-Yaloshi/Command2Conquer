void drawMenu() {
  fill(DARK_GREY);
  rect(0, 0, mainScreenStartX-1, height);
  String[] menuList = { "Play", "  Choose \n Settings", "Exit Game" };
  int buttonStartX = 50;
  int buttonStartY = 100;
  for (int i = 0; i < 3; i++) {
    menuButtonsCoords[i] = createButton(buttonStartX, buttonStartY, menuButtonWidth, menuButtonHeight, menuList[i], 1);
    buttonStartY += 100;
  }
}
