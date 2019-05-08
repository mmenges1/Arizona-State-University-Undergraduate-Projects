// Autonomous Agents - Steering Behaviors
// Nature of Code, Chapter 6
//

Vehicle v1;
PVector predator;
PVector targ;
ArrayList<Vehicle> agents;

void setup() {
  size( 800, 800 );
  Vehicle v = null;
  agents = new ArrayList<Vehicle>();
  predator = new PVector(150, 150);
  for (int i = 0; i < 6; i++)
  {
    v = new Vehicle( random(35, width - 40), random( 35, height - 40),random(25,50),random(-35,30));
    agents.add(v);
  }
}

void draw() {
  background( 128 );
  // Draw the target
  fill(255,20,20);
  ellipse(predator.x, predator.y, 15, 15);
  noFill();
  strokeWeight(1);
  ellipse(predator.x,predator.y,50,50);
  line(50,50,50,height-50);
  line(width-50,50,width-50,height-50);
  line(50,height-50,width - 50,width - 50);
  line(width - 50,50, 50,50);
  strokeWeight(0);
  // Update and draw the vehicle
  for (Vehicle v : agents)
  {
    v.update();
    v.render();
  }
}

void mouseDragged() {
  predator = new PVector( mouseX, mouseY );
}