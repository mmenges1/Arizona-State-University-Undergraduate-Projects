//In-Class Demo for AME 494:Animating Virtual Worlds 
class Projectile {
  // instance variables
  PVector location;
  PVector velocity;
  PVector acceleration;
  float radius = 20.0;
  float mass = 1.0;
  float bounciness = 0.15;

  // constructor
  Projectile( float _x, float _y ) {
    location = new PVector( _x, _y );
    velocity = new PVector( 0.0, 0.0 );
    acceleration = new PVector( 0.0, 0.0 );
  }

  // ******** Instance methods *********

  void applyForce( PVector force ) {
    PVector forse = force.copy();
    forse.div( mass );
    acceleration.add( forse );
  }

  void update() {
    velocity.add( acceleration );
    velocity.limit( 9.0 );
    location.add( velocity );
    bounce();
    acceleration.mult( 0 );
  }

  void render() {
    stroke( 0 );
    fill( 0 );
    ellipse( location.x, location.y, radius * 2, radius * 2 );
  }


  void bounce() {
    if (location.x - radius <= 0) {
      force = new PVector(0, 0);
      location.x = radius;
      velocity.x *= -0.0;
      friction();
    } else if (location.x + radius >= width) {
      force = new PVector(0, 0);
      location.x = width - radius;
      velocity.x *= -0.0;
      friction();
    }
    if (location.y - radius <= 0) {
      force = new PVector(0, 0);
      location.y = radius;
      velocity.y *= -0.0;
      friction();
    } else if (location.y + radius >= height) {
      force = new PVector(0, 0);
      location.y = height - radius;
      velocity.y *= -0.0;
      friction();
    }
  }

  void friction()
  {
    //friction
    float c = 0.1;
    PVector friction = velocity.copy();
    friction.mult(-1);
    friction.normalize();
    friction.mult(c);
  }
}