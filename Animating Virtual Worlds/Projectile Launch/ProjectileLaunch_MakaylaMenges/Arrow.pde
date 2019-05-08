//Given to AME494 Class as a demo by Loren Olson
//
// The function arrow makes it easy to draw a line with an arrow head at the end.
//
float _arrow_size = 5.0;

void arrowSize( float newArrowSize ) {
  _arrow_size = newArrowSize;
}

void arrow( float x1, float y1, float x2, float y2 ) {
  
  line( x1, y1, x2, y2 );
  
  PVector v = new PVector( x2 - x1, y2 - y1 );
  float theta = v.heading2D();
  
  pushMatrix();
  translate( x2, y2 );
  rotate( theta );
  line( -_arrow_size, -_arrow_size, 0, 0 );
  line(  0,  0, -_arrow_size, _arrow_size );
  popMatrix();
  
}