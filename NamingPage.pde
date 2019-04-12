void drawNamingPage() {
  noStroke();
  fill(WHITE);
  text("Fill in your name by clicking on the box. \n Limited to 8 characters. Only A-z and 0-9. \n Click on continue to continue.", halfMainScreenX, 0.2*height);
  int textBoxStartY = 270;
  int textBoxStartX = 440;
  drawnamingBoxesCoords(textBoxStartX, textBoxStartY, playerNames);

  int buttonStartX = round(0.75*width);
  int buttonStartY = round(0.75*height);
  continueButtonCoords(buttonStartX, buttonStartY);
}

void drawnamingBoxesCoords(int startX, int startY, String[] playerNames) {
  for (int i = 0; i <= amountOfPlayers; i++) {
    int clicked = 0;
    if (nameFillable == i) {
      clicked = 1;
    }
    namingBoxesCoords[i] = createButton(startX, startY, mainButtonWidth, mainButtonHeight, playerNames[i], clicked);
    startX += 160;
  }
}

void continueButtonCoords(int startX, int startY) {
  continueButtonCoords[0] = createButton(startX, startY, mainButtonWidth, mainButtonHeight, "Continue", 0);
}

void keyPressed() {
  String allowedChars = "123456789abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";
  if (allowedChars.contains(key + "")) {
    if (currentScreen == 0 && nameChosen == false) {
      if (playerNames[nameFillable].length() < 8) {
        playerNames[nameFillable] += key;
      }
    }
  }
  if (key == BACKSPACE && playerNames[nameFillable].length() > 0) {
    playerNames[nameFillable] = playerNames[nameFillable].substring(0, max(0, playerNames[nameFillable].length()-1));
  }
}
