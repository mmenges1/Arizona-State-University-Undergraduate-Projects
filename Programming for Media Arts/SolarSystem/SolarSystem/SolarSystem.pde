float marsD;
float marsR;
float earthD;
float earthR;
float venusD;
float venusR;
float mercuryD;
float mercuryR;
float moonP;
float moonE;
float moonD;
float faster;
void setup()
{
  size( 1000, 1000 );
  marsD = 425;
  marsR = 0;
  earthD = 300.5;
  earthR = 0;
  venusD = 199.25;
  venusR = 0;
  mercuryD = 80;
  mercuryR = 0;
  moonP = 0;
  moonE = 0;
  moonD = 0;
} 

void draw()
{
  if (key == 's' || key == 'S')
  {
    faster = .25;
  } else if (key == 'f' || key == 'F')
  {
    faster = 1;
  } else
  {
    faster = 1;
  }
  background( 50 );
  translate( width / 2.0, height / 2.0);
  noStroke();
  fill( #FAF13F );
  ellipse( 0, 0, 50, 50 );  
  mars();
  earth();
  mercury();
  venus();
}
void mars()
{
  stroke( 90 );
  noFill(); 
  ellipse( 0, 0, marsD * 2, marsD * 2 ); 
  noStroke();
  fill(#FA2B2E);
  pushMatrix();
  rotate(marsR);
  translate ( marsD, 0 );
  ellipse(0, 0, 7.77*2, 7.77*2);
  deimos();
  phobos();
  popMatrix();

  marsR += (TWO_PI / 686.97) * faster;
}
void phobos()
{
  stroke(90);
  noFill();
  ellipse( 0, 0, 100, 100 ); 
  noStroke();
  fill(#FFE3E5);
  pushMatrix();
  rotate(moonP);
  translate ( marsD/2 - 163, 0 );
  ellipse(0, 0, 4.8*2, 4.8*2);
  popMatrix();

  moonP += (TWO_PI / 30.3) * faster;
}
void deimos()
{
  stroke(90);
  noFill();
  ellipse( 0, 0, 50, 50 ); 
  noStroke();
  fill(#FFE3E5);
  pushMatrix();
  rotate(moonD);
  translate ( marsD/2 - 190, 0 );
  ellipse(0, 0, 6.2*2, 6.2*2);
  popMatrix();

  moonD += (TWO_PI / 7.5) * faster;
}
void mercury()
{
  stroke( 90 );
  noFill(); 
  ellipse( 0, 0, mercuryD * 2, mercuryD * 2 ); 
  noStroke();
  fill(#6A1AED);
  pushMatrix();
  rotate(mercuryR);
  translate ( mercuryD, 0 );
  ellipse(0, 0, 6.8*2, 6.8*2);
  popMatrix();

  mercuryR += (TWO_PI / 87.96) * faster;
}
void venus()
{
  stroke( 90 );
  noFill(); 
  ellipse( 0, 0, venusD * 2, venusD * 2 ); 
  noStroke();
  fill(#0DCAFC);
  pushMatrix();
  rotate(venusR);
  translate ( venusD, 0 );
  ellipse(0, 0, 9.8*2, 9.8*2);
  popMatrix();

  venusR += (TWO_PI / 224.7) * faster;
}
void earth()
{
  stroke( 90 );
  noFill(); 
  ellipse( 0, 0, earthD * 2, earthD * 2 ); 
  noStroke();
  fill(#03FFC2);
  pushMatrix();
  rotate(earthR);
  translate ( earthD, 0 );
  ellipse(0, 0, 10.2*2, 10.2*2);
  moon();
  popMatrix();

  earthR += (TWO_PI / 365.25) * faster;
}
void moon()
{
  stroke(90);
  noFill();
  ellipse( 0, 0, 75, 75 ); 
  noStroke();
  fill(#DBFCF4);
  pushMatrix();
  rotate(moonE);
  translate ( earthD -263, 0 );
  ellipse(0, 0, 6.8*2, 6.8*2);
  popMatrix();

  moonE += (TWO_PI / 22.7) * faster;
}

