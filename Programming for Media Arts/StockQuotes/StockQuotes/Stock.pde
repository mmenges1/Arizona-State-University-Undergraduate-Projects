class Stock
{
  String name;
  String price;
  float x;
  float y;

  Stock( String _name, String _price, float _x, float _y )
  {
    name = _name;
    price = _price;
    x = _x;
    y = _y;
  }

  void render()
  {
    fill( 255 );
    text( name + " " + price, x, y );
    x = x + -4.0;
    if (x + width() < 0) 
    {
      x = x;
    }
  }

  float width()
  {
    String s = name + " " + price;
    float sw = textWidth(s);
    return sw;
  }
}

