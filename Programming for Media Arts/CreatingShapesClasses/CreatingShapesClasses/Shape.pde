class Shape
{
  int y;
  int x;
  int size;
  int r;
  int g;
  int b;
  //Contructor
  Shape(int newX, int newY) {
    x = newX;
    y = newY;
    size = (int) random(20, 100);
    r = (int) random(256);
    g = (int) random(256);
    b = (int) random(256);
  }

  void render() {

    stroke( 0 );
    fill( r, g, b );
    
    if (r <= 125 )
    {
      ellipse( x, y, size, size);
    } 
    else if (r <= 255)
    {
      rect( x - (size/2), y - (size/2) , size, size);
    }
  }
}

