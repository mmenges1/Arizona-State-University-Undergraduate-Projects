Walker kevin;

void setup() 
{
  size( 500, 500 ); 
  kevin = new Walker();
}

void draw()
{
  background( 128 );
  kevin.step();
  kevin.render();
}