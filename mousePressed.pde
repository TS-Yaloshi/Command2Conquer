void mousePressed() {
  clickMenuButtons();
  if (currentScreen == 0) {
    clickField();
    clickEndScreenButton();
    clickPlayerNames();
    clickcontinueButtonCoords();
  }
  if (currentScreen == 1) {
    clickAmountOfPlayers();
    clickBoardSize();
  }
}

void clickMenuButtons() {
  for (int i = 0; i < menuButtonsCoords.length; i++) {
    if (mouseX >= menuButtonsCoords[i][0] && mouseX <= menuButtonsCoords[i][0]+menuButtonWidth & mouseY >= menuButtonsCoords[i][1] && mouseY <= menuButtonsCoords[i][1]+menuButtonHeight) {
      currentScreen = i;
    }
  }
}
void clickAmountOfPlayers() {
  for (int i = 0; i < playerAmountButtonsCoords.length; i++) {
    if (mouseX >= playerAmountButtonsCoords[i][0] && mouseX <= playerAmountButtonsCoords[i][0]+mainButtonWidth && mouseY >= playerAmountButtonsCoords[i][1] && mouseY <= playerAmountButtonsCoords[i][1]+mainButtonHeight) {
      amountOfPlayers = i;
    }
  }
}
void clickBoardSize() {
  for (int i = 0; i < playingFieldButtonsCoords.length; i++) {
    if (mouseX >= playingFieldButtonsCoords[i][0] && mouseX <= playingFieldButtonsCoords[i][0]+mainButtonWidth && mouseY >= playingFieldButtonsCoords[i][1] && mouseY <= playingFieldButtonsCoords[i][1]+mainButtonHeight) {
      playingBoardSize = i+5;
    }
  }
}
void clickField() {
  for (int i = 0; i < amountOfFields; i++) {
    if (nameChosen == true && fieldTakenBy[i] == -1 && gameOver == false && mouseX >= playingFieldList[i][0] && mouseX <= playingFieldList[i][0]+fieldWidth && mouseY >= playingFieldList[i][1] && mouseY <= playingFieldList[i][1]+fieldWidth) {
      if (playingFieldList[i][5] == 9) {
        fieldTakenBy[i] = 6;
        amountOfMines = amountOfMines - 1;
        playerInfo[currentPlayer][1] = playerInfo[currentPlayer][1] - 1;
        fieldsClicked++;
      } else {
        fieldTakenBy[i] = currentPlayer;
        playerInfo[currentPlayer][1] = playerInfo[currentPlayer][1] + 1;
        fieldsClicked++;
        playingFieldList[i][6] = 1;
        squareAndHorizonVerticalCheck(i);
      }
      nextPlayer();
    }
  }
}

void clickEndScreenButton() {
  for (int i = 0; i < endScreenButtonCoords.length; i++) {
    if (gameOver == true && mouseX >= endScreenButtonCoords[i][0] && mouseX <= endScreenButtonCoords[i][0]+mainButtonWidth & mouseY >= endScreenButtonCoords[i][1] && mouseY <= endScreenButtonCoords[i][1]+mainButtonHeight) {
      resetGame();
      currentScreen = 0;
    }
  }
}

void clickPlayerNames() {
  for (int i = 0; i < namingBoxesCoords.length; i++) {
    if (nameChosen == false && mouseX >= namingBoxesCoords[i][0] && mouseX <= namingBoxesCoords[i][0]+mainButtonWidth && mouseY >= namingBoxesCoords[i][1] && mouseY <= namingBoxesCoords[i][1]+mainButtonHeight) {
      nameFillable = i;
    }
  }
}

void clickcontinueButtonCoords() {
  for (int i = 0; i < continueButtonCoords.length; i++) {
    if (mouseX >= continueButtonCoords[i][0] && mouseX <= continueButtonCoords[i][0]+mainButtonWidth && mouseY >= continueButtonCoords[i][1] && mouseY <= continueButtonCoords[i][1]+mainButtonHeight) {
      nameChosen = true;
    }
  }
}

void squareAndHorizonVerticalCheck(int i) {
  for (int index2 = 1; index2 <= 10; index2++) {
    int rightSide = playingBoardSize*index2-1;
    int leftSide = playingBoardSize*index2-playingBoardSize;
    if (i == rightSide) {
      checkUpperRightClick(i);
      checkBottomRightClick(i);
      checkAbove(i);
      checkBelow(i);
      checkLeft(i);
    } else if (i == leftSide) {
      checkUpperLeftClick(i);
      checkBottomLeftClick(i);
      checkAbove(i);
      checkBelow(i);
      checkRight(i);
    } else if (i > leftSide && i < rightSide) {
      checkUpperRightClick(i);
      checkUpperLeftClick(i);
      checkBottomLeftClick(i);
      checkBottomRightClick(i);
      checkLeft(i);
      checkRight(i);
      checkBelow(i);
      checkAbove(i);
    }
  }
}

void checkUpperLeftClick(int i) {
  if (i+playingBoardSize+1 < 101) {
    if (fieldTakenBy[i] == fieldTakenBy[i+1] && fieldTakenBy[i] == fieldTakenBy[i+playingBoardSize] && fieldTakenBy[i] == fieldTakenBy[i+playingBoardSize+1] && fieldTakenBy[i] == currentPlayer) {
      playerInfo[currentPlayer][1] += 3;
    }
  }
}

void checkUpperRightClick(int i) {
  if (i+playingBoardSize-1 < 100 && i-1 > -1) {
    if (fieldTakenBy[i] == fieldTakenBy[i-1] && fieldTakenBy[i] == fieldTakenBy[i+playingBoardSize] && fieldTakenBy[i] == fieldTakenBy[i+playingBoardSize-1] && fieldTakenBy[i] == currentPlayer) {
      playerInfo[currentPlayer][1] += 3;
    }
  }
}

void checkBottomLeftClick(int i) {
  if (i+1 < 101 && i-playingBoardSize > -1) {
    if (fieldTakenBy[i] == fieldTakenBy[i+1] && fieldTakenBy[i] == fieldTakenBy[i-playingBoardSize] && fieldTakenBy[i] == fieldTakenBy[i-playingBoardSize+1] && fieldTakenBy[i] == currentPlayer) {
      playerInfo[currentPlayer][1] += 3;
    }
  }
}

void checkBottomRightClick(int i) {
  if (i+playingBoardSize < 101 && i-playingBoardSize-1 > -1) {
    if (fieldTakenBy[i] == fieldTakenBy[i-1] && fieldTakenBy[i] == fieldTakenBy[i-playingBoardSize] && fieldTakenBy[i] == fieldTakenBy[i-playingBoardSize-1] && fieldTakenBy[i] == currentPlayer) {
      playerInfo[currentPlayer][1] += 3;
    }
  }
}

void checkLeft(int i) {
  if (i-1 > -1) {
    if (fieldTakenBy[i] == fieldTakenBy[i-1] && fieldTakenBy[i] == currentPlayer) {
      playerInfo[currentPlayer][1] += 1;
    }
  }
}

void checkRight(int i) {
  if (i+1 < 101) {
    if (fieldTakenBy[i] == fieldTakenBy[i+1] && fieldTakenBy[i] == currentPlayer) {
      playerInfo[currentPlayer][1] += 1;
    }
  }
}

void checkAbove(int i) {
  if (i-playingBoardSize > 0) {
    if (fieldTakenBy[i] == fieldTakenBy[i-playingBoardSize] && fieldTakenBy[i] == currentPlayer) {
      playerInfo[currentPlayer][1] += 1;
    }
  }
}

void checkBelow(int i) {
  if (i+playingBoardSize < 100) {
    if (fieldTakenBy[i] == fieldTakenBy[i+playingBoardSize] && fieldTakenBy[i] == currentPlayer) {
      playerInfo[currentPlayer][1] += 1;
    }
  }
}
