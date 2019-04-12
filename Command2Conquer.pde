/** Beroepsproduct / Stijn van Ewijk / oktober 2018 */

PImage backgroundImage;
boolean ifStarted, gameOver, nameChosen;
int halfMainScreenX, amountOfFields, amountOfMines, amountOfPlayers, playingBoardSize, pastMillis, currentScreen, currentPlayer, fieldsClicked, nameFillable;
final int mainScreenStartX = 300;
final int fieldWidth = 50;
final int menuButtonWidth = 200;
final int menuButtonHeight = 100;
final int mainButtonWidth = 150;
final int mainButtonHeight = 75;
final color BLACK = color(0);
final color WHITE = color(255);
final color LIGHT_GREY = color(100);
final color DARK_GREY = color(40);
String[] playerNames;
int[][] continueButtonCoords = new int[1][2];                    // x-coord, y-coord
int[][] namingBoxesCoords = new int[5][2];                       //  x-coord, y-coord
int[][] menuButtonsCoords = new int[5][2];                  //  x-coord, y-coord
int[][] endScreenButtonCoords = new int[1][2];              //  x-coord, y-coord
int[][] playerAmountButtonsCoords = new int[5][2];          //  x-coord, y-coord
int[][] playingFieldButtonsCoords = new int[6][2];          //  x-coord, y-coord
int[][] playingFieldList = new int[100][7];                // x-coord, y-coord, width, fieldNumber, fieldTakenBy[index], mineAssigned, clicked
int[][] playerInfo = { { 1, 0, 0 }, { 2, 0, 0 }, { 3, 0, 0 }, { 4, 0, 0 }, { 5, 0, 0 } };    // spelernummer / aantal punten / kleur
int[] fieldTakenBy = new int[playingFieldList.length];

void setup() {
  pastMillis = 0;
  playingBoardSize = 5;
  currentScreen = -1;
  resetGame();
  strokeWeight(3);
  textSize(20);
  size(1400, 800);
  halfMainScreenX = round(mainScreenStartX+(0.5*(width-mainScreenStartX)));
  backgroundImage = loadImage("start3.jpg");
}

void draw() {
  drawBackground();
  switch(currentScreen) {
  case -1:
    drawMenu();
    break;
  case 0: 
    if (nameChosen == false) {
      drawNamingPage();
    } else {
      drawGame();
    }
    break;
  case 1: 
    resetGame();
    drawSettings();
    break;
  case 2: 
    exit();
    break;
  }
}
