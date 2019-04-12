int[] createButton(int x, int y, int buttonWidth, int buttonHeight, String text, int clicked) {
  if (clicked == 1) {
    stroke(0);
  } else {
    noStroke();
  }
  fill(LIGHT_GREY);
  float textX = x+0.5*buttonWidth;
  float textY = y+0.5*buttonHeight;
  rect(x, y, buttonWidth, buttonHeight);
  textAlign(CENTER, CENTER);
  fill(WHITE);
  text(text, textX, textY);
  int[] b = {x, y};
  return(b);
}
