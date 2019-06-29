class SolarSystem{
  PVector solPosition;
  color solColor;
  
  Planet sun;
  Planet[] planets;
  
  SolarSystem(int x, int y, color _color, int amount){
    // set galaxy options
    solPosition = new PVector(x,y);
    solColor = _color;
    
    planets = new Planet[amount];
    
    // set planet
    sun = new Planet(null, 50, 0, 0);
    for(int i = 0; i < planets.length; i++){
      
      float radius = random(10, 40);
      float distance = map(radius, 10, 40, 30, 250);
      float speed = map(radius, 10, 40, 0.05f, 0.01f);
      
      planets[i] = new Planet(sun, radius, distance, speed);
    }
  }
  
  void update(){
    sun.update();
    for(int i = 0; i < planets.length; i++){
      planets[i].update();
    }
  }
  
  void show(){
    sun.show();
    for(int i = 0; i < planets.length; i++){
      planets[i].show();
    }
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