
float elevation;
float power;
PVector corner;
Projectile num1;
PVector gravity;
PVector push;
boolean check;
float gravityX;
float gravityY;
PVector wind;
float windX;
float windY;
PVector upperCorner;
boolean check2;
float ran;
PVector force;
float y;
float x;
float windRand;


void setup() 
{
  size( 1000, 1000 );

  elevation = -120.95;
  power = .2;
  check = false;
  check2 = false;
  windRand = random(0.0125);
  corner = new PVector( 50, height - 50 );
  ran = random( 100, width - 50 );
  float scale = 250;
  wind = new PVector( windRand, 0);
  x = scale * power * cos( elevation );
  y = scale * power * sin( elevation );
  force = new PVector( x, y );
}


void draw()   
{
  background( 125 );
  stroke ( 255 );
  strokeWeight( 2 );
  //  windRand = random(0.0125);
  fill(255);
  rect( ran, height - 50, 50, 50);
  push = new  PVector( 1.0, -0.8 );
  push.mult( 5 );
  float scale = 250;
  x = scale * power * cos( elevation );
  y = scale * power * sin( elevation );
  force = new PVector( x, y );
  PVector endPoint = PVector.add( corner, force );
  gravity = new PVector( 0.0, 0.1 );

  stroke( 200 );
  strokeWeight( 1 );
  fill(255);
  float w = 50;
  ellipse( 50, height - 29, w, w );
  stroke( 240 );
  strokeWeight( 3 );
  arrow( corner.x, corner.y, endPoint.x, endPoint.y );     
  arrow( width - 10, 50, width - (windRand + 25), 50);

  if (check)
  {
    wind = new PVector( windRand, 0);
    //     wind.normalize();
    wind.mult(-1);
    check = false;
  }
  if (num1 != null)
  {     
    num1.applyForce( gravity );
    num1.applyForce( wind );
    num1.friction();
    num1.update();
    num1.render();
    if (num1.location.y - num1.radius <= 0) {
      num1.applyForce( new PVector(0, 0));
    } else if (num1.location.y + num1.radius >= height) {
      num1.applyForce( new PVector(0, 0));
    }
    if ((((num1.location.x) >= ran)) && num1.location.x <= (ran + 25) && (num1.location.y + num1.radius) >= (height - 25) && num1.location.y <= (height))
    {
      num1 = null;
      ran = random( 100, width - 50 );
    }
  }
}

void keyPressed() {
  if (key == 'a')
    this.elevation -= 0.05;
  else if (key == 'd')
    this.elevation += 0.05;
  else if (key == 's')
    this.power -= 0.05;
  else if (key == 'w')
    this.power += 0.05;
  if (key == ENTER) 
  {
    num1 = new Projectile( 50, height - 50 );
    force = new PVector( x, y );
    check = true;
    force.mult(power);
    num1.applyForce( force );
    windRand = random(0.0125);
    // println(windRand);
  } else if (key == BACKSPACE) 
  {
    check = false;
  }
} 