
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  float fillR, fillG, fillB, fillA;

  ParticleSystem( PVector loc ) {
    origin = loc.copy();
    particles = new ArrayList<Particle>();
    fillR = 255.0;
    fillG = 255.0;
    fillB = 255.0;
    fillA = 255.0;
  }

  void run() {
   // addParticle();

    Iterator<Particle> it = particles.iterator();
    while (it.hasNext ()) {
      Particle p = it.next();
      p.applyForce(gravity);
      p.update();
      p.render();
      if (p.isDead()) {
        it.remove();
      }
    }
  }

  // Add a particle at a given position
  void addParticle( PVector point ) {
    Particle p = new Particle( point );
    p.velocity = new PVector(random(-1, 1), random(-2, 0));
    p.setColor( fillR, fillG, fillB, fillA );
    particles.add( p );
  }

  // Add a particle at the ParticleSystem origin
  void addParticle() {
    addParticle( origin );
  }

  void setColor( float r, float g, float b, float a ) {
    fillR = r;
    fillG = g;
    fillB = b;
    fillA = a;
  }
}