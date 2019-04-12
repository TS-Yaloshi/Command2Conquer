void drawSettings() {
  noStroke();
  fill(WHITE);
  text("Amount of players", halfMainScreenX, 240);
  text("Boardsize", halfMainScreenX, 390);

  String[] playerList = { "1", "2", "3", "4", "5" } ;
  int buttonStartY = 270;
  int buttonStartX = 440;
  drawPlayerAmountButtons(buttonStartX, buttonStartY, playerList);

  buttonStartY += 150;
  buttonStartX = 370;
  String[] fieldList = { "5x5", "6x6", "7x7", "8x8", "9x9", "10x10" } ;
  drawPlayingFieldButtons(buttonStartX, buttonStartY, fieldList);
}

void drawPlayerAmountButtons(int startX, int startY, String[] playerList) {
  for (int i = 0; i < 5; i++) {
    int clicked = 0;
    if (amountOfPlayers == i) {
      clicked = 1;
    }
    playerAmountButtonsCoords[i] = createButton(startX, startY, mainButtonWidth, mainButtonHeight, playerList[i], clicked);
    startX += 160;
  }
}

void drawPlayingFieldButtons(int startX, int startY, String[] fieldList) {
  for (int i = 0; i < 6; i++) {
    int clicked = 0;
    if (playingBoardSize == i+5) {
      clicked = 1;
    }
    playingFieldButtonsCoords[i] = createButton(startX, startY, mainButtonWidth, mainButtonHeight, fieldList[i], clicked);
    startX += 160;
  }
}
