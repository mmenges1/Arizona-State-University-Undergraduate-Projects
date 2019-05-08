class Ship {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass = 1.0;
  float speed;
  float radius;
  float diameter;
  float angle;
  float aVelocity;
  float aAcceleration;
  int burn;
  boolean inContact;


  Ship() {
    location = new PVector( width / 2, height / 2 );
    velocity = new PVector( 0, 0 );
    acceleration = new PVector( 0, 0 );
    angle = 0;
    aVelocity = 0.0;
    aAcceleration = 0.0;
    speed = 0.2;
    radius = 8;
    diameter = radius * 2;
    inContact = false;
    burn = 0;
  }


  void render() {
    // save the current transformation state
    pushMatrix(); 

    stroke(240);
    strokeWeight(1);
    noFill();
    translate( location.x, location.y );
    rotate( angle );
    if (inContact) {
      fill(255, 0, 0);
      triangle(-8, 5, -8, -5, 8, 0);
    }
    line( -11, 6, 8, 0 );
    line( -11, -6, 8, 0 );
    line( -8, 5, -8, -5 );
    if (burn > 0) {
      line( -8, 4, -14, 0 );
      line( -8, -4, -14, 0 );
      burn--;
    }

    // restore the previous transformation state
    popMatrix();
  }


  void applyForce( PVector force ) {
    PVector f = force.copy();
    f.div( mass );
    acceleration.add( f );
  }


  void applyAngular( float force ) {
    float f = force / mass;
    aAcceleration += f;
  }


  void update() {
    velocity.add( acceleration );
    velocity.limit( 100.0 );
    location.add( velocity );
    wrap();
    acceleration.mult( 0 );

    aVelocity += aAcceleration;
    angle += aVelocity;
    aAcceleration = 0;
  }


  void forward( float magnitude ) {

    // TODO: calculate a force to change acceleration
    float m = map(magnitude, 0.0, 0.2, 0.0, 0.015);
    float one = m * cos( angle );
    float two = m * sin( angle );
    PVector f = new PVector( one, two );
    applyForce(f);
    burn = 2;
  }


  void spin( float magnitude ) {

    // TODO: calculate a change to angular acceleration
    float m = map(magnitude, 0.0, 0.2, 0.0, 0.015);
    applyAngular(m);
  }


  void wrap() {
    if (location.x + radius < 0)
      location.x = width + radius;
    else if (location.x - radius > width)
      location.x = -radius;

    if (location.y + radius < 0)
      location.y = height + radius;
    else if (location.y - radius > height)
      location.y = -radius;
  }


  void contact() {
    inContact = true;
  }


  void noContact() {
    inContact = false;
  }
}