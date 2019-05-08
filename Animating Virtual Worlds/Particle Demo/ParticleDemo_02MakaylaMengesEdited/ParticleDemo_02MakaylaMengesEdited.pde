import java.util.Iterator;

ArrayList<ParticleSystem> systems;
ParticleSystem p;
PVector gravity = new PVector( 0, 0.04 );
Shapes shape;
ArrayList<Shapes> shapes;
Iterator<Shapes> it;
Shapes s;

void setup() {
  size( 1200, 720 );
  systems = new ArrayList<ParticleSystem>();
  shapes = new ArrayList<Shapes>();
  for (int i = 0; i < 4; i++)
  {
    shape = new Shapes();
    shapes.add(shape);
  }
  it = shapes.iterator();
}

void draw() {
  background( 128 );
  for (ParticleSystem ps : systems) {
    ps.run();
  }
  for (Shapes s : shapes)
  {
    s.create();
  }
}


void mousePressed() {
  shatter();
}

void shatter()
{
 
  PVector point = new PVector(mouseX, mouseY);
  it = shapes.iterator();

  while (it.hasNext()) {
    s = it.next();
    if (point.x > s.x && point.x < (s.x + s.rectW) && point.y > s.y && point.y < (s.y + s.rectH))
    {
      p = new ParticleSystem(new PVector(s.x, s.y));
      p.fillR = s.r;
      p.fillG = s.g;
      p.fillB = s.b;
      for (float i = s.x; i <= (s.x + s.rectW); i += 8)
      {
        for (float j = s.y; j < (s.y + s.rectH); j += 8)
        {
          p.addParticle(new PVector(i, j));
        }
      }
      it.remove();
      systems.add(p);
      break;
    }
  }
}