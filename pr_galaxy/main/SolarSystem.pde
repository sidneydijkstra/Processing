class SolarSystem{
  PVector solPosition;
  color solColor;
  
  Planet sun;
  Planet p;
  
  SolarSystem(int x, int y, color c){
    // set galaxy options
    solPosition = new PVector(x,y);
    solColor = c;
    
    // set planet
    sun = new Planet(null,null);
    sun.mass = 100;
    p = new Planet(sun, new PVector((width/2) - 80, height/2));
  }
  
  void update(){
    sun.update();
    p.update();
  }
  
  void show(){
    sun.show();
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