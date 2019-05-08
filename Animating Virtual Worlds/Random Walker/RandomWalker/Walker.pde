class Walker
{
  //instance variables
  int x;
  int y;
  float s;

  //constructor
  Walker()
  {
    x = width/2;
    y = height/2;
    s = 35;
  }
  // draw this object
  void render()
  {
    noStroke();
   // scale(s);
    rect( x, y, s, s );
  }
  //take one step
  void step()
  {
    float chance = random( 1 );  //0.0, 1.0
    if (chance <= 0.30) // 30%
    {
    // move to right
        x += 1;
    }
    else if (chance <= 0.40) //10%
    {
    // move to left
        x -= 1;
    }
    else if (chance <= 0.60) // 20%
    {
    // move up
        y -= 1;
    }
    else if (chance <= .61) // 1% // Change Size Randomly
    {
     fill(221,random(0,256),random(0, 255));   //Change Color randomly 
     s += random(-5,15);
    }
    else // 39%
    {
    // move down
        y += 1;
    }

    wrap();
  }
  void wrap()
  {
    if (x < 0)
    {
      x = x + width;
    } 
    else if (x > width)
    {
      x = x - width;
    } 
    else if (y < 0)
    {
      y = y + height;
    } 
    else if (y > height)
    {
      y = y - height;
    }
  }
}