void drawGame() {
  int scoreboardStartY = round(0.5*height-0.5*playingBoardSize*fieldWidth);
  int scoreboardStartX = 400;
  String scoreboardText = "Scoreboard";
  int marge = 5;
  int marge2 = 2*marge;                                                      //these variables are used in multiple functions
  if (!gameOver) {
    if (!ifStarted) {
      currentPlayer = round(random(0, amountOfPlayers));
      amountOfFields = playingBoardSize*playingBoardSize;
      int boardStartY = round(0.5*height-0.5*playingBoardSize*fieldWidth);
      int fieldNumber = 1;
      int index = 0;
      createBoard(boardStartY, fieldNumber, index);      //creates the first state of the board

      createMines();                                      //creates a random amount of mines and assigns them to fields

      ArrayList<Integer> availableColors = new ArrayList<Integer>();
      availableColors.add(color(0, 255, 0));
      availableColors.add(color(255, 0, 0));
      availableColors.add(color(0, 255, 255));
      availableColors.add(color(255, 255, 0));
      availableColors.add(color(255, 0, 255));
      assignColorsToPlayers(availableColors);                            //assigns random colors to players

      pastMillis = millis();                            //reset for the timer
    }
    ifStarted = true;
    checkAndDrawFields();                                        //checks if field data has changed (by user clicks), draws if changed

    String gameRules = " Capture a field for 1 point. \n Capture a field horizontally or vertically next \n to your own field for an extra point per field. \n Capture a square of 4 fields for 3 extra points.";
    drawGameRules(marge, marge2, gameRules);        //draws the game rules

    drawScoreBoard(scoreboardStartY, scoreboardStartX, scoreboardText, marge2);                  //draws the scoreboard

    int infoBoardWidth = 200;
    int infoBoardStartX = round(halfMainScreenX-(0.5*infoBoardWidth));
    int infoBoardStartY = 25;
    int infoBoardHeight = 100;
    String playerText = "It is " + playerNames[currentPlayer] + "'s turn.";
    String mineText = "There are " + amountOfMines + " mines left.";
    drawInfoBoard(infoBoardWidth, infoBoardStartX, infoBoardStartY, infoBoardHeight, playerText, mineText);        //draws the information board with user turn and amount of mines left

    int timerWidth = 125;
    int timerStartX = round(halfMainScreenX-(0.5*timerWidth))+200;
    int timerStartY = 25;
    int timerHeight = 100;
    String timerText = "Your turn has \n" + countDown() + "\n seconds left.";
    drawTimer(timerWidth, timerStartX, timerStartY, timerHeight, timerText);                    //draws the timer for the game window

    checkIfGameOver();                                                                        //checks if the game is over, proceed to next screen
  } else {
    int rectWidth = round(0.4*width);
    int rectStartX = round(halfMainScreenX-0.5*rectWidth);
    int rectStartY = round(0.5*height-0.5*playingBoardSize*fieldWidth);
    int rectHeight = round(0.3*height);
    drawEndScreen(rectWidth, rectStartX, rectStartY, rectHeight, marge2);                 //endscreen with the winner's message and statistics

    drawScoreBoard(scoreboardStartY, scoreboardStartX, scoreboardText, marge2);                //scoreboard is visible at the end of the game for players to see
  }
}

void createBoard(int startY, int fieldNumber, int index) {
  for (int i = 0; i < playingBoardSize; i++) {
    int startX = round(halfMainScreenX-0.5*playingBoardSize*fieldWidth);
    playingFieldList[index] = new int[] { startX, startY, fieldWidth, fieldNumber, fieldTakenBy[index], 0, 0 };
    for (int j = 0; j < (playingBoardSize-1); j++) {
      startX = startX + (fieldWidth+1);
      fieldNumber++;
      index++;
      playingFieldList[index] = new int[] { startX, startY, fieldWidth, fieldNumber, fieldTakenBy[index], 0, 0 };
    }
    startY = startY + (fieldWidth+1);
    fieldNumber++;
    index++;
  }
}

void createMines() {
  for (int i = 0; i < amountOfFields; i++) {
    playingFieldList[i][5] = ceil(random(0, 9));
    if (playingFieldList[i][5] == 9) {
      amountOfMines = amountOfMines + 1;
      playingFieldList[i][6] = 1;
    }
  }
}

void assignColorsToPlayers(ArrayList<Integer> availableColors) {
  for (int i = 0; i <= amountOfPlayers; i++) {
    int colorNumber = (int)random(availableColors.size());
    int pickColor = availableColors.get(colorNumber);
    playerInfo[i][2] = pickColor;
    availableColors.remove(colorNumber);
  }
}

void checkAndDrawFields() {
  stroke(0);
  for (int i = 0; i < amountOfFields; i++) {
    fill(LIGHT_GREY);
    float textX = playingFieldList[i][0]+0.5*fieldWidth;
    float textY = playingFieldList[i][1]+0.5*fieldWidth;
    if (fieldTakenBy[i] < 6 && fieldTakenBy[i] > -1) {
      fill(playerInfo[fieldTakenBy[i]][2]);
    } 
    drawField(textX, textY, i);
    if (fieldTakenBy[i] == 6) {
      drawMine(textX, textY);
    }
  }
}

void drawField(float x, float y, int i) {
  rect(playingFieldList[i][0], playingFieldList[i][1], fieldWidth, fieldWidth);
  textAlign(CENTER, CENTER);
  fill(WHITE);
  textSize(15);
  text(playingFieldList[i][3], x, y);
}

void drawMine(float x, float y) {
  PImage bombImage = loadImage("bomb.png");
  imageMode(CENTER);
  image(bombImage, x, y, fieldWidth, fieldWidth);
}


void drawScoreBoard(int startY, int startX, String scoreboardText, int marge) {                                                                           
  fill(LIGHT_GREY);
  rect(startX, startY, 150, 200);
  fill(WHITE);
  textAlign(LEFT, TOP);
  text(scoreboardText, startX+marge, startY);
  for (int i = 0; i <= amountOfPlayers; i++) {
    fill(playerInfo[i][2]);
    startY = startY + 20;
    text(playerNames[i] + " :   " + playerInfo[i][1], startX+marge, startY);
  }
}

void drawGameRules(int marge, int marge2, String gameRules) {
  fill(LIGHT_GREY);
  rect(mainScreenStartX+marge, 0+marge, 350, 110);
  fill(WHITE);
  textAlign(LEFT, TOP);
  text(gameRules, mainScreenStartX+marge2, marge2);
}

void drawInfoBoard(int boardWidth, int infoBoardStartX, int infoBoardStartY, int boardHeight, String playerText, String mineText) {
  fill(LIGHT_GREY);
  rect(infoBoardStartX, infoBoardStartY, boardWidth, boardHeight);
  textAlign(CENTER, CENTER);
  fill(WHITE);
  text(playerText, infoBoardStartX+0.5*boardWidth, infoBoardStartY+0.25*boardHeight);
  text(mineText, infoBoardStartX+0.5*boardWidth, infoBoardStartY+0.75*boardHeight);
}

void drawTimer(int timerWidth, int timerStartX, int timerStartY, int timerHeight, String timerText) {
  fill(LIGHT_GREY);
  rect(timerStartX, timerStartY, timerWidth, timerHeight);
  textAlign(CENTER, CENTER);
  fill(WHITE);
  text(timerText, timerStartX+0.5*timerWidth, timerStartY+0.5*timerHeight);
}

void checkIfGameOver() {
  if (fieldsClicked + amountOfMines == amountOfFields) {
    gameOver = true;
  }
}

int countDown() {
  int countDown = 30+pastMillis/1000 - millis()/1000;
  if (countDown < 0) {
    nextPlayer();
  }
  return countDown;
}

void nextPlayer() {
  pastMillis = millis();
  currentPlayer = currentPlayer + 1;
  if (currentPlayer > amountOfPlayers) {
    currentPlayer = 0;
  }
}
