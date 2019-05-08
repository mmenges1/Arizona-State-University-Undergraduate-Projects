Shape[] listOfShapes;
int current = 0;
int x = (int) random( width );
int y = (int) random( height );
void setup() {
  size( 600, 400 );
  listOfShapes = new Shape[1000];
}

void draw() {
  background( 128 );
  for ( int i = 0; i < current; i++)
  {
    listOfShapes[i].render();
  }
}

void mousePressed()
{
  listOfShapes[current] = new Shape(mouseX, mouseY);
  current++;
}
void keyPressed() 
{
  if (keyCode == DELETE) {
    if (current > 0)
    {
      for (int i = current; i > current; i--)
      {
        listOfShapes[current] = listOfShapes[current-1];
      }
      current--;
    }
  }
  if (key == 'r' || key == 'R') {
    current = 0;
    /*  while (current > 0)  
     {
     for (int i = current; i > current; i--)
     {
     listOfShapes[current] = listOfShapes[current-1];
     }
     current--;
     }
     current = 0;
     listOfShapes = new Shape[1000];*/
     }
  }

