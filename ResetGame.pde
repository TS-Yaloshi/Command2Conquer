void resetGame() {
  ifStarted = false;
  nameChosen = false;
  fieldsClicked = 0;
  gameOver = false;
  playerNames = new String[] { "Player1", "Player2", "Player3", "Player4", "Player5" } ;
  for (int i = 0; i < playingFieldList.length; i++) {
    fieldTakenBy[i] = -1;
  }
  for (int i = 0; i < playerInfo.length; i++) {
    playerInfo[i][1] = 0;
  }
  currentPlayer = round(random(0, amountOfPlayers));
  amountOfMines = 0;
}
