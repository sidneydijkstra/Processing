class Galaxy{
  
  PVector position;
  color col;
  
  Galaxy(int x, int y, color c){
    position = new PVector(x,y);
    col = c;
  }
  
  void show(){
  
  }
  
  public int getX(){
    return (int)position.x;
  }
  
  public int getY(){
    return (int)position.y;
  }
  
  public color getColor(){
    return col;
  }
  
}