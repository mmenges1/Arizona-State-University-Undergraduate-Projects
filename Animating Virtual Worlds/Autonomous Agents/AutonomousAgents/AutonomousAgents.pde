// Autonomous Agents - Steering Behaviors
// Complex Systems, Flocking
// Nature of Code, Chapter 6.10 to 6.13
// Flocking with obstacle avoidance. (via Reynolds)



ArrayList<Vehicle> agents;
ArrayList<Obstacle> obstacles;
boolean debug = true;


void setup() {
  size( 700, 700 );
  agents = new ArrayList<Vehicle>();
  // 1 == Cat group, 2 == mouse, 3 == Human, 4 == Dog
  for (int i = 0; i < 5; i++) {
    Vehicle v = new Vehicle( random(width), random(height) );
    v.group = 2;
    agents.add( v );
  }
    for (int i = 0; i < 30; i++) {
    Vehicle v = new Vehicle( random(width), random(height) );
    v.group = 3;
    agents.add( v );
  }
    for (int i = 0; i < 15; i++) {
    Vehicle v = new Vehicle( random(width), random(height) );
    v.group = 1;
    agents.add( v );
  }
    for (int i = 0; i < 10; i++) {
    Vehicle v = new Vehicle( random(width), random(height) );
    v.group = 4;
    agents.add( v );
    }
  obstacles = new ArrayList<Obstacle>();
  for (int i = 0; i < 25; i++) {
  obstacles.add( new Obstacle(  random(width-15), random(height-15), random(5,20) ) );
  }
}

void draw() {
  background( 25,50,10,50 );
  
  for (Obstacle ob : obstacles) {
    ob.render();
  }

  for (Vehicle v : agents) {

    v.run(agents);
    
  }
}