class Group{
  boolean _done;
  
  float angle = 0;
  float k;
  int resolution;
  
  ArrayList<Circle> childeren;
  ArrayList<PVector> path;
  
  public Group(int amount, float radius, float k, int resolution){
    this.k = k;
    this.angle = 0;
    this.resolution = resolution;
    
    this._done = false;
    
    childeren = new ArrayList<Circle>();
    path = new ArrayList<PVector>();
    
    Circle temp = new Circle(width/2, height/2, radius);
    childeren.add(temp);
    
    for(int i = 1; i < amount; i++){
      Circle last = childeren.get(i-1);
      Circle cir = new Circle(last.radius/3);
      childeren.add(cir);
    }
  }
  
  public Circle getLastCircle(){
    return childeren.get(childeren.size()-1);
  }
  
  public void show(){
    if(!_done){
      for(Circle cir : childeren){
        cir.show();
      }
    }

    beginShape();
    stroke(255, 0 ,0);
    for(PVector pos : path){
      vertex(pos.x, pos.y);
    }
    endShape();
  }
  
  public void update(int s){
    if(_done)
      return;
      
    for(int i = 0; i < s; i++){
      for(int j = 1; j < childeren.size(); j++){
        Circle c = childeren.get(j);
        float speed = pow(k, j-1) / resolution;
        
        c.rotateRound(childeren.get(j-1), angle, speed);
      }
      
      angle += 0.01;
      print(angle + " - ");
      
      Circle c = this.getLastCircle();
      path.add(new PVector(c.position.x, c.position.y));
    }
    
    if(angle >= 65){
      _done = true;
    }
  }
}