class Ball 
{
  int ballLocationX;
  int ballLocationY;
  float velocityX;
  float velocityY;
  int ballRadius;
  float ballSize;
  float bounciness;
  float gravity;
  int r;
  int g;
  int b;

Ball(int x, int y, float vX, float vY, int r1, int g1, int b1 ){
 ballLocationX = x;
 ballLocationY = y;
 velocityX = vX;
 velocityY = vY;
 ballRadius = 20;
 ballSize = ballRadius * 2;
 bounciness = 0.85;
 gravity = 0.5;
 r = r1;
 g = g1;
 b = b1;
  
}

  void render() 
  {
    fill( r, g, b );
    ellipse( ballLocationX, ballLocationY, ballSize, ballSize );
  }

  void move() 
  {

    ballLocationX = ballLocationX + (int) velocityX;
    velocityY = velocityY + gravity;
    ballLocationY = ballLocationY + (int) velocityY;

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
}

