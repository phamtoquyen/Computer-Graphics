int centerSquareWidth;
int smallSquareWidth;
float k = 0.5;
int recCount = 0;
float s, t;
void setup() {
  size(600, 600);
  centerSquareWidth = width/3;
  smallSquareWidth = centerSquareWidth/2;
}

void draw() {
  background(225);
  // calculate offset values based on mouse position
  s = mouseX - (centerSquareWidth/2 + smallSquareWidth);
  t = 3 * centerSquareWidth/4;
  
  // draw middle square
  fill(0);
  rect(width/2 - centerSquareWidth/2, height/2 - centerSquareWidth/2, centerSquareWidth, centerSquareWidth);
  // call function to draw four smaller squares
  drawSmallSquares(width/2, height/2, centerSquareWidth/2, s, t, recCount);
}

void drawSmallSquares(float x, float y, float smallSquareWidth, float s, float t, int recCount) {
  noStroke();
  rect(x + s - smallSquareWidth/2, y - t - smallSquareWidth/2, smallSquareWidth, smallSquareWidth, recCount);
  rect(x - s - smallSquareWidth/2, y + t - smallSquareWidth/2, smallSquareWidth, smallSquareWidth, recCount);
  rect(x + t - smallSquareWidth/2, y + s - smallSquareWidth/2, smallSquareWidth, smallSquareWidth, recCount);
  rect(x - t - smallSquareWidth/2, y - s - smallSquareWidth/2, smallSquareWidth, smallSquareWidth, recCount);

  recursiveCall(x/2, y/2, smallSquareWidth/2, s/2, t/2, recCount + 1);
  recursiveCall(width - x/2, y/2, smallSquareWidth/2, s/2, t/2, recCount + 1);
  recursiveCall(width - x/2, height - y/2, smallSquareWidth/2, s/2, t/2, recCount + 1);
  recursiveCall(x/2, height - y/2, smallSquareWidth/2, s/2, t/2, recCount);
}


void recursiveCall(float x, float y, float squareWidth, float s, float t, int recCount) {
  noStroke();
  rect(x + s - squareWidth/2, y - t - squareWidth/2, squareWidth, squareWidth);
  rect(x - s - squareWidth/2, y + t - squareWidth/2, squareWidth, squareWidth);
  rect(x + t - squareWidth/2, y + s - squareWidth/2, squareWidth, squareWidth);
  rect(x - t - squareWidth/2, y - s - squareWidth/2, squareWidth, squareWidth);

  if (recCount < 4) {
    recursiveCall(x/2, y/2, squareWidth/2, s/2, t/2, recCount + 1);
    recursiveCall(width - x/2, y/2, squareWidth/2, s/2, t/2, recCount + 1);
    recursiveCall(width - x/2,height - y/2, squareWidth/2, s/2, t/2, recCount + 1);
    recursiveCall(x/2, height - y/2, squareWidth/2, s/2, t/2, recCount + 1);
  }
}
