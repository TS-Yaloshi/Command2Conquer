void drawEndScreen(int rectWidth, int rectStartX, int rectStartY, int rectHeight, int marge) {
  drawEndScreenMessage(rectWidth, rectStartX, rectStartY, rectHeight);
  endScreenButtonCoords[0] = createButton(rectStartX+rectWidth-marge-menuButtonWidth, rectStartY+rectHeight-marge-menuButtonHeight, menuButtonWidth, menuButtonHeight, "Play Again", 1);
}

void drawEndScreenMessage(int rectWidth, int rectStartX, int rectStartY, int rectHeight) {
  fill(DARK_GREY);
  rect(rectStartX, rectStartY, rectWidth, rectHeight);
  textAlign(CENTER, CENTER);
  fill(WHITE);

  int pointsOfWinner = playerInfo[0][1];
  int winner = playerInfo[0][0];
  String winnerName = playerNames[0];
  int winnerPointDifference = 100;
  text(decideWinnerAndPointDifference(pointsOfWinner, winner, winnerName, winnerPointDifference), rectStartX+0.5*rectWidth, rectStartY+0.3*rectHeight);
}

String decideWinnerAndPointDifference(int pointsOfWinner, int winner, String winnerName, int winnerPointDifference) {
  for (int i = 1; i < playerInfo.length; i++) {
    if (playerInfo[i][1] > pointsOfWinner) {
      winner = playerInfo[i][0];
      pointsOfWinner = playerInfo[i][1];
      winnerName = playerNames[winner-1];
    } else if (playerInfo[i][1] == pointsOfWinner) {
      winnerName += " & " + playerNames[i];
    }
  }
  String pointText = "\n won with a difference of " + pointDifference(pointsOfWinner, winnerPointDifference) + " points.";
  winnerName += pointText;
  return winnerName;
}

int pointDifference(int pointsOfWinner, int winnerPointDifference) {
  for (int i = 0; i < playerInfo.length; i++) {
    if (pointsOfWinner - playerInfo[i][1] < winnerPointDifference && pointsOfWinner - playerInfo[i][1] > 0) {
      winnerPointDifference = pointsOfWinner - playerInfo[i][1];
    }
  }
  if (winnerPointDifference == 100) {
    winnerPointDifference = 0;
  }
  return winnerPointDifference;
}
