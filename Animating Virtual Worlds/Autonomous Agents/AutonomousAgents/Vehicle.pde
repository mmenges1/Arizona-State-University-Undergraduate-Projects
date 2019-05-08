
class Vehicle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  int group; // 1 == Cat group, 2 == mouse, 3 == Human, 4 == Dog
  // Data for the Agent location.
  //  PVector position;
  float radius;
  float angle;
  //  PVector velocity1;

  // These two variables describe limited viewing ability
  float angleOfView;
  float viewDistance;


  Vehicle(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-2, 2), random(-1, 1));
    location = new PVector(x, y);
    r = 3.0;
    // Arbitrary values for maxspeed and
    // force; try varying these!
    maxspeed = 1.5;
    maxforce = 0.05;
    group = 1;

    //   position = new PVector( width/2.0, height/2.0 );
    //    velocity1 = new PVector( 1.0, 0.0 );
    radius = 10.0;
    angle = 0.0;
    angleOfView = (PI / 4) + 2.380;
    viewDistance = 250.0;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
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
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    if (group == 1) {
      fill(255, 165, 20); //orange
    } else if (group == 2) {
      fill(206, 206, 206); //Grey
    } else if (group == 3) {
      fill(42, 192, 37);//Human
    } else
    {
      fill(117, 62, 8);//Dog
    }
    stroke(0);
    beginShape();
    vertex(0, -r*2);
    vertex(-r*1.5, r*2);
    vertex(r*1.5, r*2);
    endShape(CLOSE);
    popMatrix();
  }


  void run(ArrayList<Vehicle> vehicles) {
    if (group == 1) //Cat
    {
      for (Vehicle v : vehicles)
      {
        float distance = location.dist( v.location );
        if ( distance < 50) {
          {
            if (v.group == 3 || v.group == 4)
            {
              maxspeed = 3.0;
              flee(v.location);
            } else
            {
              maxspeed = 1.5;
              separate(vehicles);
              wander();
            }
          }
        }
      }
    } else if (group == 2) //Mouse
    {
        wander();
        avoid(obstacles);
    } else if (group == 3) //Human
    {
      for (Vehicle v : vehicles)
      {
        float distance = location.dist( v.location );
        if ( distance < 50) {
          {
            if (v.group == 2)
            {
              maxspeed = 3.0;
              flee(v.location);
            } else
            {
              maxspeed = 1.5;
              flock(vehicles);
            }
          }
        }
      }
    } else //Dog
    {
      for (Vehicle v : vehicles)
      {
        float distance = location.dist( v.location );
        if ( distance < 40) {
          {
            if (v.group == 1)
            {
              seek(v.location);
            } else
            {
              flock(vehicles);
            }
          }
        }
      }
    }
    update();
    borders();
    render();
  }
  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Vehicle> vehicles) {
    PVector sep = separate(vehicles);   // Separation
    PVector ali = align(vehicles);      // Alignment
    PVector coh = cohesion(vehicles);   // Cohesion
    PVector avoid = avoid(obstacles);

    float sepWeight = 1.5;
    float aliWeight = 1.0;
    float cohWeight = 1.0;
    float avoidWeight = 2.0;

    if (avoid.mag() >= 0.01) {
      sepWeight = 0.2;
      cohWeight = 0.01;
      aliWeight = 0.01;
    }

    // Arbitrarily weight these forces
    sep.mult(sepWeight);
    ali.mult(aliWeight);
    coh.mult(cohWeight);
    avoid.mult(avoidWeight);

    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    applyForce(avoid);
  }
  void flee(PVector target) {
    float d = location.dist(target);
    if (d < 100)
    {
      println("flee");
      PVector desired = PVector.sub(target, location);
      desired.mult(-1);
      desired.mult(maxspeed*3);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce*3);
      applyForce(steer);
    }
  }
  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  // Wraparound
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Vehicle> vehicles) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Vehicle other : vehicles) {
      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align(ArrayList<Vehicle> vehicles) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Vehicle other : vehicles) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed*1.5);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  PVector cohesion (ArrayList<Vehicle> vehicles) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (Vehicle other : vehicles) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the location
    } else {
      return new PVector(0, 0);
    }
  }

  PVector wander() {
    float strength = 40.0;
    float circleDistance = 80.0;
    PVector circleLocation = velocity.copy();
    if (velocity.mag() < 0.0001) {
      circleLocation = new PVector( 1, 0 );
    }
    circleLocation.normalize();
    circleLocation.mult(circleDistance);
    circleLocation.add(location);

    float u = location.x / 100.0 + frameCount / 60.0;
    float v = location.y / 100.0;
    float rate = 0.3;
    float wander = (noise( u, v ) * rate) - (rate / 2.0);
    float heading = velocity.heading();
    float x = strength * cos( wander + heading ) + circleLocation.x;
    float y = strength * sin( wander + heading ) + circleLocation.y;
    PVector wanderTarget = new PVector( x, y );
    return seek( wanderTarget );
  }

  PVector avoid(ArrayList<Obstacle> obstacles) {
    float distance = 100.0;
    float angle = velocity.heading();
    float ax = distance / 2.0;
    float ay = 0.0;
    float awidth = distance;
    float aheight = r * 2;
    Obstacle closestObstacle = null;
    float closestDistance = 1000000.0;
    PVector closestB = null;
    for (Obstacle ob : obstacles) {
      PVector b = PVector.sub( ob.location, location );
      b.rotate( -angle );
      float bwidth = ob.radius * 2.0;
      float bheight = bwidth;
      if ((abs(ax - b.x) * 2 < (awidth + bwidth)) && (abs(ay - b.y) * 2 < (aheight + bheight))) {
        if (b.x < closestDistance) {
          closestObstacle = ob;
          closestDistance = b.x;
          closestB = b;
        }
      }
    }
    if (closestObstacle != null) {
      PVector steer = new PVector(0.0, -closestB.y);
      steer.rotate(angle);
      steer.normalize();
      steer.mult(maxspeed*1.5);
      steer.limit(maxforce*1.5);
      return steer;
    }
    return new PVector(0, 0);
  }
}