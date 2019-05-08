float ballLocationX = 300;
float ballLocationY = 200;
float velocityX = 4;
float velocityY = -12;
float ballRadius = 20;
float ballSize = ballRadius * 2;
float bounciness = 0.85;
float gravity = 0.5;

void setup() {
  size( 600, 400 );
}

void draw() {
  background( 128 );
  moveBall();
  drawBall();
}
void moveBall() {

  ballLocationX = ballLocationX + velocityX;
  velocityY = velocityY + gravity;
  ballLocationY = ballLocationY + velocityY;

  if ((ballLocationX + ballRadius) > width) {
    velocityX = velocityX * -bounciness;
    velocityY *= bounciness;
    ballLocationX = width - ballRadius;
  } else if ((ballLocationX - ballRadius) < 0) {
    velocityX = velocityX * -bounciness;
    velocityY *= bounciness;
    ballLocationX = ballRadius;
  }

  if ((ballLocationY + ballRadius) > height) {
    velocityY = velocityY * -1.0 * bounciness;
    velocityX *= bounciness;
    ballLocationY = height - ballRadius;
  } else if ((ballLocationY - ballRadius) < 0) {
    velocityY = velocityY * -1.0 * bounciness;
    velocityX *= bounciness;
    ballLocationY = ballRadius;
  }
}
void drawBall() {
  fill( ballLocationX/2, ballLocationY/2, (ballLocationX*ballLocationY)/2);
  ellipse( ballLocationX, ballLocationY, ballSize, ballSize );
}

