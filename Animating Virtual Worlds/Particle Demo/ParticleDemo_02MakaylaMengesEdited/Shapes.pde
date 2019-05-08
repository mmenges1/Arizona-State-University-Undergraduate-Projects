class Shapes
{
  float x;
  float y;
  float rectW;
  float rectH;
  float r;
  float g;
  float b;

  Shapes()
  {
    rectW = random(150, 350);
    rectH = random(200, 300);
    x = random(0, width-rectW);
    y = random(0, height-rectH);
    r = random(30, 255);
    g = random(10, 255);
    b = random(0, 255);
  }

  void create()
  {
    noStroke();
    fill(r, g, b);
    rect(x, y, rectW, rectH);
  }
}