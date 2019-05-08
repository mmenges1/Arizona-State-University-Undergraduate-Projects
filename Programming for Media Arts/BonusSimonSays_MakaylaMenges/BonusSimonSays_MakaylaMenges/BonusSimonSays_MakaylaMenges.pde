// The sound file "vibes-a1.aif" is from the preinstalled Max Msp 7 resources folder 
// The sound files, "triangle.wav", "fingercymbals-large.wav", and "cymbal-ride-bell.wav", are 
// from this link, https://archive.org/download/OpenPathMusic44V1/OpenPathMusic44V1.zip , and this link was 
// given to my AME 112 class by Todd Ingalls for an assignment.
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim;
AudioSample kick;
boolean pressInsideButton;
boolean pressInsideButton1;
boolean pressInsideButton2;
boolean pressInsideButton3;
boolean isButtonArmed;
boolean isButtonArmed1;
boolean isButtonArmed2;
boolean isButtonArmed3;
int x1;
int y1;
int x2;
int y2;
int t1;
int t2;
int[] b;
int[] c;
int cnt;
int current;
boolean flag;
void setup() {
  size( 900, 800 );
  // t2 = millis();
  minim = new Minim(this);
  pressInsideButton = false;
  pressInsideButton1 = false;
  pressInsideButton2 = false;
  pressInsideButton3 = false;
  isButtonArmed = false;
  isButtonArmed1 = false;
  isButtonArmed2 = false;
  isButtonArmed3 = false;
  current = 0;
  //initial location of rectangles
  x1 = 200;
  y1 = 200;
  x2 = 400;
  y2 = 400;
  //initial sequence array to hold the variables for user to guess
  b = new int[4];
  //users input array to test against array b
  c = new int[4];
  flag = false;
  cnt = 0;
  //creates random sequence
  for (int i = 0; i < 4; i++)
  { 
    b[i] = int(random(1, 5));
    println( b[i]);
  }
}
void draw()
{  
  background( 128 );
  rectMode( CORNERS );
  if ( flag && current < 4  )
  {
    t1 = millis();
    frameRate(1);
    beginSeq();
    if (t2 < t1 + 1500 )
    {
      current++;
    }
    t1 = t2;
  } else
  {
    frameRate(60);
    afterSeq();
  }
  if ( cnt == 4 )
  {
    println( b[0] + ", " + b[1] + ", " + b[2] +", " + b[3] +", " +c[0] + ", " + c[1] + ", " + c[2] + ", " + c[3]);
    if ( c[0] == b[0]  && c[1] == b[1] && c[2] == b[2] && c[3] == b[3] )
    {
      fill(255, 255, 255);
      textSize(100);
      textAlign(CENTER);
      text("You Win!", width/2, height/2);
      noLoop();
    } else
    {
      fill(255, 255, 255);
      textSize(100);
      textAlign(CENTER);
      text("You Lose!", width/2, height/2);
      noLoop();
    }
  }
  if ( flag == false )
  {
    fill(255, 255, 255);
    textSize(50);
    textAlign(CENTER);
    text("Press ENTER or RETURN to start", width/2, height/2);
  }
}



void mousePressed() 
{
  pressInsideButton = false;
  pressInsideButton1 = false;
  pressInsideButton2 = false;
  pressInsideButton3 = false;
  if (mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2) {
    pressInsideButton = true;
  }
  if (mouseX >= x1+300 && mouseX <= x2+300 && mouseY >= y1 && mouseY <= y2) {
    pressInsideButton1 = true;
  }
  if (mouseX >= x1 && mouseX <= x2 && mouseY >= y1+300 && mouseY <= y2+300) {
    pressInsideButton2 = true;
  }
  if (mouseX >= x1+300 && mouseX <= x2+300 && mouseY >= y1+300 && mouseY <= y2+300) {
    pressInsideButton3 = true;
  }
}

void mouseReleased() 
{
  if (cnt < 4 )
  {
    if (pressInsideButton && mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2) {
      isButtonArmed = !isButtonArmed;
      kick = minim.loadSample("triangle.wav", 512 );
      kick.trigger();
      c[cnt] = 1;
      cnt++;
    }
    if (pressInsideButton1 && mouseX >= x1+300 && mouseX <= x2+300 && mouseY >= y1 && mouseY <= y2) {
      isButtonArmed1 = !isButtonArmed1;
      kick = minim.loadSample("fingercymbals-large.wav", 512 );
      kick.trigger();
      c[cnt] = 2; 
      cnt++;
    }
    if (pressInsideButton2 && mouseX >= x1 && mouseX <= x2 && mouseY >= y1+300 && mouseY <= y2+300) {
      isButtonArmed2 = !isButtonArmed2;
      kick = minim.loadSample("cymbal-ride-bell.wav", 512 );
      kick.trigger();
      c[cnt] = 3;   
      cnt++;
    }
    if (pressInsideButton3 && mouseX >= x1+300 && mouseX <= x2+300 && mouseY >= y1+300 && mouseY <= y2+300) {
      isButtonArmed3 = !isButtonArmed3;
      kick = minim.loadSample("vibes-a1.aif", 512 );
      kick.trigger();
      c[cnt] = 4;
      cnt++;
    }
  }
}

void beginSeq()
{
  //top left rect
  if (b[current] == 1) 
  {
    t2 = millis();
    kick = minim.loadSample("triangle.wav", 512 );
    kick.trigger();
    fill( 100, 0, 0 );
  } else
  {
    fill(255, 0, 0);
  }
  rect( x1, y1, x2, y2, 7 );
  //top right rect
  if (b[current] == 2) 
  {
    t2 = millis();
    kick = minim.loadSample("fingercymbals-large.wav", 512 );
    kick.trigger();
    fill(0, 0, 100);
  } else
  {
    fill(0, 0, 255);
  }
  rect( x1+300, y1, x2+300, y2, 7 );
  //bottom left rect
  if (b[current] == 3) 
  {
    t2 = millis();
    kick = minim.loadSample("cymbal-ride-bell.wav", 512 );
    kick.trigger();
    fill(0, 100, 0);
  } else
  {
    fill(0, 255, 0);
  }
  rect( x1, y1+300, x2, y2+300, 7 );
  //bottom right rect
  if (b[current] == 4) 
  {
    t2 = millis();
    kick = minim.loadSample("vibes-a1.aif", 512 );
    kick.trigger();
    fill(100, 0, 100);
  } else
  {
    fill(255, 0, 255);
  }
  rect( x1+300, y1+300, x2+300, y2+300, 7 );
}

void afterSeq()
{
  //after sequence
  //top left rect
  if (isButtonArmed == true ) 
  {
    fill( 100, 0, 0 );
    if ( frameCount % 84 == 0 )
    {
      isButtonArmed = false;
      kick.stop();
      fill( 255, 0, 0 );
    }
  } else
  {
    fill( 255, 0, 0 );
  }
  rect( x1, y1, x2, y2, 7 );
  //bottom left rect
  if (isButtonArmed1 == true ) 
  {
    fill(0, 0, 100);
    if ( frameCount % 84 == 0 )
    {
      kick.stop();
      isButtonArmed1 = false;
      fill( 0, 0, 255 );
    }
  } else
  {
    fill( 0, 0, 255 );
  }
  rect( x1+300, y1, x2+300, y2, 7 );
  //
  if (isButtonArmed2 == true) 
  {
    fill(0, 100, 0);
    if ( frameCount % 84 == 0 )
    {
      kick.stop();
      isButtonArmed2 = false;
      fill( 0, 255, 0 );
    }
  } else
  {
    fill( 0, 255, 0);
  }
  rect( x1, y1+300, x2, y2+300, 7 );
  if (isButtonArmed3 == true) 
  {
    fill(100, 0, 100);
    if ( frameCount % 84 == 0 )
    {
      kick.stop();
      isButtonArmed3 = false;
      fill( 255, 0, 255 );
    }
  } else
  {
    fill( 255, 0, 255);
  }
  rect( x1+300, y1+300, x2+300, y2+300, 7 );
}
void keyPressed()
{
  if ( key == ENTER || key == RETURN)
  {
    flag = true;
  }
}

