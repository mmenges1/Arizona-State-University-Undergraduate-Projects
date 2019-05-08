Ball a;
Ball b;
Ball c;

void setup() {
  size( 600, 400 );
  a = new Ball(100, 100, 4, -12, 30, 100, 200 );
  b = new Ball(50, 50, 2, -10, 56, 176, 75 );
  c = new Ball(300, 90, 5, -9, 87, 36, 134 );
}

void draw() {
  background( 128 );
  
    
  a.move();
  a.render();
  b.move();
  b.render();
  c.move();
  c.render();
  
}
