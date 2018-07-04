class Planet{
  
  color col;
  float radius;
  float distance;
  
  PVector position;
  float speed;
  float angle;
  
  Planet parent;
  
  Planet(Planet _parent, float _radius, float _distance, float _speed){
    // set color size and mass
    col = color(random(255),random(255),random(255));
    
    radius = _radius; //random(50, 200);
    distance = _distance;
    speed = _speed;
    angle = random(0, 360);
    
    // set pos if parent is null set pos to center
    if (_parent == null){
      position = new PVector(width/2, height/2);
    }else{
      position = new PVector();
    }
    
    parent = _parent;
  }
  
  void show(){
    fill(col);
    ellipse(position.x, position.y, radius, radius);
  }
  
  void update(){
    
    if(parent == null){
      //this.applyForce(this.attract(parent));
    }else{
      this.rotateRound(parent, distance, angle);
      angle += speed;
    }
    
  }
  
  public void rotateRound(Planet _planet, float _distance, float _angle){
    float rDiv = _planet.radius/2 + radius/2 + _distance;
    position.x = _planet.position.x + rDiv * cos(_angle);
    position.y = _planet.position.y + rDiv * sin(_angle);
  }
  
}