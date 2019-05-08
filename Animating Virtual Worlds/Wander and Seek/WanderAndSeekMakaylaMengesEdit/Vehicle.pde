
class Vehicle {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  int check = 0; //0 is coasting and 1 is seeking mode
  int seekMode;
  PVector target1;
  PVector target;
  int rd = 20;
  int g = 255;
  int b = 20;
  float rate = PI;
  float strength = 10;
  PVector wander;
  int stage = 1;
  int startTime;

  Vehicle(float x, float y, float str, float rat) {
    rate = rat;
    strength = str;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    location = new PVector(x, y);
    r = 4.0;
    // Arbitrary values for maxspeed and
    // force; try varying these!
    maxspeed = 2;
    maxforce = 0.1;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
    boundary();
    rate = random(radians(180));
    flee(predator);

    if (stage == 1)
    {
      rd = 20;
      g = 255;
      wander();
    } else {
      rd = 255;
      g = 20;
    }
  }

  // Newton’s second law; we could divide by mass if we wanted.
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void render() {
    // Vehicle is a triangle pointing in
    // the direction of velocity; since it is drawn
    // pointing up, we rotate it an additional 90 degrees.
    float theta = velocity.heading() + PI/2;
    fill(rd, g, b);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r*1.5, r*2);
    vertex(r*1.5, r*2);
    endShape(CLOSE);
    popMatrix();
  }

  void arrive( PVector target ) {
    PVector desired = PVector.sub(target, location);
    float d = location.dist(target);
    if (d < 50)
    {
      float speed = map(d, 0, 100, 0, maxspeed);
      desired.mult(-speed);
    } else
    {
      desired.mult(maxspeed);
    }

    desired.normalize();
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  void wander()
  {
    println("wander");
 //   ellipse(location.x, location.y,15,15);
    wander = new PVector(location.x, location.y);
    wander.rotate(rate);
    PVector desired = PVector.sub(wander, location);
    //  desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
   // boundary();
  }
  void flee(PVector target) {
    float d = location.dist(target);
    if (d < 50)
    {
      println("flee");
      startTime = millis();
      check = 1;
      stage = 2;
      PVector desired = PVector.sub(target, location);
      desired.mult(-1);
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce*1.5);
      applyForce(steer);
    }
    
      int now = millis();
      int elapsedTime = now - startTime;
      if (elapsedTime > 2000)
      {
        stage = 1;
      }
  }
  void boundary()
  {
    println("bounds");
    PVector desired = new PVector(maxspeed, velocity.y);
    if (location.x < 100) {
      desired = new PVector(maxspeed, velocity.y);
    } else if (location.x > width - 100) {
      desired = new PVector(-maxspeed, velocity.y);
    }
    if (location.y < 100) {
      desired = new PVector(maxspeed, velocity.x);
    } else if (location.y > height - 100) {
      desired = new PVector(-maxspeed, velocity.x);
    }
    //    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
}