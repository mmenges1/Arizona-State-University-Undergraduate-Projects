class Missile {
  PVector location;
  PVector velocity;
  float collision_width;
  boolean live;
  float radius;
  int age;
  
  Missile(float rot) {
    location = new PVector( 8, 0 );
    float x1 = location.x * cos(rot) - location.y * sin(rot);
    float y1 = location.y * cos(rot) + location.x * sin(rot);
    location.x = ship.location.x + x1;
    location.y = ship.location.y + y1;
    velocity = new PVector( (x1 / 3.0), (y1 / 3.0) );
    collision_width = 3.0;
    live = true;
    radius = 1.5;
    age = 0;
  }
  
  
  void render() {
    pushMatrix();
    translate( location.x, location.y );
    stroke(255.0);
    noFill();
    strokeWeight(1.0);
    
    beginShape();
    vertex(-0.5,-1.5);
    vertex( 0.5,-1.5);
    vertex( 1.5,-0.5);
    vertex( 1.5, 0.5);
    vertex( 0.5, 1.5);
    vertex(-0.5, 1.5);
    vertex(-1.5, 0.5);
    vertex(-1.5,-0.5);
    endShape(CLOSE);
    popMatrix();
  }
  
  
  void update() {
    location.add( velocity );
    wrap();
    age++;
    if (age > 120)
      live = false;
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
  
  
  boolean collision() {
    for (Asteroid a : asteroids) {
      float d = location.dist( a.location );
      //if (asteroids[i].collide(d)) {
      //  live = false;
      //  return(true);
      //}
    }
    return(false);
  }
}