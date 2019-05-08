// asteroids!
import java.util.Iterator;

Ship ship;
ArrayList<Asteroid> asteroids;
ArrayList<Missile> missiles;
PFont font;


void setup() {
  size( 800, 800 );
  font = createFont( "Courier", 32 );
  textFont( font );
  reset();
}


// Everything neccessary to start a fresh game should be done here.
void reset() {
  ship = new Ship();
  create_asteroids();
  missiles = new ArrayList<Missile>();
}


void create_asteroids() {
  asteroids = new ArrayList<Asteroid>();
  for (int i = 0; i < 5; i++) {
    Asteroid asteroid = new Asteroid( random( 0, width), random( 0, height) , random( 20, 60 ) );
    asteroids.add( asteroid );
  }
}


void draw() {
  background( 0 );
  
  ship.inContact = false;
  
  // update/render all asteroids
  for (Asteroid a : asteroids) {
    a.update( ship );
    a.render();
  }
  
  // update/render all missiles
  Iterator<Missile> it = missiles.iterator();
  while (it.hasNext()) {
    Missile m = it.next();
    if (m.live == false) {
      it.remove();
    }
    else {
      m.update();
      m.render();
    }
    
  }
  
  // update/render the user controlled ship
  ship.update();
  ship.render();
}


void keyPressed() {
  if (key == 'j') {
    ship.spin( -0.2 );
  }
  else if (key == 'l') {
    ship.spin( 0.2 );
  }
  else if (key == 'i') {
    // forward thrusters
    ship.forward( 1.0 );
  }
  else if (key == 'k') {
  }
  else if (key == ' ') {
    missiles.add( new Missile( ship.angle ) );
  }
}