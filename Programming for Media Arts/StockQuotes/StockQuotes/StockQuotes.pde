// StockQuotes
// Starting point for assignment 9.
// Makayla Menges
PFont font;
String[] quotes = {
  "ADBE", "68.60", "AAPL", "529.36", "ADSK", "51.41", "CSCO", "21.87", 
  "EA", "30.17", "FB", "67.07", "GOOG", "1201.52", "HPQ", "31.78", 
  "INTC", "25.41", "MSFT", "40.49", "NVDA", "18.56", "YHOO", "38.24"
};
Stock[] list;
Stock a;
float x = 400;
float y = 300;
float speed = -4.0;
float spaceBetweenQuotes = 54.0;
void setup() {
  size( 600, 400 );
  font = createFont( "HelveticaNeue", 36 );
  textFont( font );
  create_stock_list();
}
void draw()
{
  frameRate(30);
  background( 0 );
  fill( 128, 128, 128, 85);
  noStroke();
  rectMode(CORNER);
  rect(0, 300, 600, 100);
  int i = 0;
  while (i < 12) 
  {
    list[i].render();
    if ( list[0].x +list[0].width() < 0 )
    {
      list[0].x = list[list.length-1].x + list[list.length-1].width()+ spaceBetweenQuotes;
    } else if (i > 0 && list[i].x +list[i].width() < 0)
    {
      list[i].x = list[i-1].x + list[i-1].width()+ spaceBetweenQuotes;
    }
    i++;
  }
}

void create_stock_list() {
  list = new Stock[12];
  int i = 0;
  int j = 0;
  float x = y;
  while (i < 12) {
    String stockName = quotes[j];
    String stockPrice = quotes[j+1];
    Stock aStock = new Stock( stockName, stockPrice, x, 390 );

    list[i] = aStock;
    x = x + aStock.width() + spaceBetweenQuotes;
    i = i + 1;
    j = j + 2;
  }
}

