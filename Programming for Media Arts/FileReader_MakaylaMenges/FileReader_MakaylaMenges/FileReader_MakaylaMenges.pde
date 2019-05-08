
float[] temp = {};
float maxTemp;
float minTemp;

void setup() {
  size( 1200, 800 ); 
  minTemp = 200;
  maxTemp = 0;
  String[] lines = loadStrings( "us_avg_temp_1895-2015.csv" );
  for (int i = 4; i < lines.length; i++) 
  {
    String[] a = split( lines[i], "," );
    
    float value = float( a[1] );
    if (value > maxTemp) 
    {
      maxTemp = value;
    }
    if (value < minTemp) 
    {
      minTemp = value;
    }
    
    temp = append( temp, value );
//    years = append( years, a[0] );
  }
}

void draw() {
  
  background( 128 );
  stroke( 0 );
  noFill();
  rect( 100, 100, width - 200, height - 200 );
  stroke( 0 );
//  fill( 100 );
  float w = ((float)width - 200.0) / (float)temp.length;
  for (int i = 0; i < temp.length; i++)
  {
    float mappedValue = map( temp[i], minTemp, maxTemp, 0, height - 200 );
    float mappedPurple = map( temp[i], minTemp, maxTemp, 0, 255 );
    float x = 100.0 + i * w;
    float y = height - 100 - mappedValue;
    float h = mappedValue;
    fill( mappedPurple, 0, mappedPurple );
    rect( x, y, w, h );
  }
  textSize( 32 );
  fill( 255 );
  text("Year", 600, 750);
  text("Temp.", 0, 400);
  text("Average Temp. in US from 1895 - 2015", 300, 50);
  textSize( 16 );
  text("x - ", 70, 700);
  text("|", 100, 720);
  text("y", 100, 735);
  text("Min Temp: ", 800, 720);
  text(minTemp, 890, 720);
  text("Max Temp: ", 800, 750);
  text(maxTemp, 890, 750);


  noLoop();
}






