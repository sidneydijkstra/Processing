class Tile {

  PVector position;
  int _x;
  int _y;
  
  int _gridX;
  int _gridY;

  int _width;
  int _height;
  
  Boolean isWalkable = true; // is this tile walkable
  Tile parent = null; // the parent of this tile
  
  int gCost; // dis from start to tile
  int hCost; // dis from end to tile
  int fCost; // gCost + hCost
  
  color DEBUGCOLOR;
  
  public Tile(int _gX, int _gY, int _x, int _y, int _width, int _height) {
    // set tile grid postition
    this._gridX = _gX;
    this._gridY = _gY;
    
    // set tile position
    this.position = new PVector(_x + _width/2, _y + _height/2);
    this._x = _x;
    this._y = _y;

    // set tile size
    this._width = _width;
    this._height = _height;
    
    DEBUGCOLOR = color(255);
  }
  
  public void update() {
  }
  
  public void show() {
    if(!this.isWalkable){
      fill(130);
    }else{
      fill(DEBUGCOLOR);
    }
    
    stroke(0);
    rect(_x, _y, _width, _height);
  }

  public PVector getPosition(){
    return position;
  }

  public int gridX() {
    return _gridX;
  }

  public int gridY() {
    return _gridY;
  }
}