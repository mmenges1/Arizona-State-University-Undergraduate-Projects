class Asteroid {
  PVector location;
  PVector velocity;
  float radius;
  float diameter;
  float angle;
  float angularVelocity;
  float size;
  float[] xv = { -1.0, 1.0, 2.5, 2.5, 3.0, 2.0, 1.0, 0.0,-1.0,-1.5,-1.0,-3.0,-3.0,-2.0 };
  float[] yv = { -3.0,-3.0,-1.5,-0.5, 0.5, 2.5, 2.5, 3.0, 2.5, 2.0, 0.0, 1.0,-1.0,-2.5 };
  
  
  Asteroid( float initX, float initY, float initDiameter ) {
    location = new PVector( initX, initY );
    velocity = new PVector( random( -1.0, 1.0 ), random( -1.0, 1.0 ) );
    diameter = initDiameter;
    radius = diameter / 2.0;
    angle = random( 360 );
    angularVelocity = random( -0.02, 0.02 );
    size = radius / 3.0;
  }
  
  
  // wrap asteroid movement across the window edges
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


  void render() {
    pushMatrix();
    translate( location.x, location.y);
    rotate(angle);
    stroke( 255 );
    strokeWeight(1);
    noFill();
    
    beginShape();
    for (int i = 0; i < xv.length; i++) {
      vertex(xv[i]*size,yv[i]*size);
    }
    endShape(CLOSE);
    popMatrix();
  }
  

  void update( Ship s ) {
    location.add( velocity );
    angle += angularVelocity;
    wrap();
    if (hit( s ) == true) {
      s.contact();
    }
  }


  // returns true if this asteroid hits the ship passed to it
  // otherwise, return false
  boolean hit( Ship s ) {
    float distance = location.dist( s.location );
    float boundary = (diameter + s.diameter) / 2.0;
    if (distance <= boundary)
      return true;
    else
      return false;
  }
  
}