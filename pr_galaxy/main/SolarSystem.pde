class SolarSystem{
  PVector solPosition;
  color solColor;
  
  Planet p;
  
  SolarSystem(int x, int y, color c){
    // set galaxy options
    solPosition = new PVector(x,y);
    solColor = c;
    
    // set planet
    p = new Planet();
  }
  
  void show(){
    p.show();
  }
  
  // get solarsystem x
  public int getX(){
    return (int)solPosition.x;
  }
  // get solarsystem y
  public int getY(){
    return (int)solPosition.y;
  }
  // get solarsystem color
  public color getColor(){
    return solColor;
  }

}