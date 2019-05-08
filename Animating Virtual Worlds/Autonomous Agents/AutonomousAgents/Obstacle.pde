class Obstacle {
  PVector location;
  float radius;
  
  Obstacle( float x, float y, float r ) {
    location = new PVector( x, y );
    radius = r;
  }
  
  void render() {
    noStroke( );
    strokeWeight( 1 );
    fill( 25,100,25 );
    ellipse( location.x, location.y, radius * 2, radius * 2 );
  }
}