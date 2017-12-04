class Planet{
  
  color col;
  float size;
  float mass;
  
  PVector pos;
  PVector vel;
  PVector acc;
  
  
  Planet parent;
  
  Planet(Planet _parent, PVector _pos){
    // set color size and mass
    col = color(random(255),random(255),random(255));
    size = 25;//random(50, 200);
    mass = 10;
    
    // set pos if parent is null set pos to center
    if (_parent == null){
      pos = new PVector(width/2, height/2);
    }else{
      pos = _pos;
    }
    
    // set acc and vel
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    
    parent = _parent;
  }
  
  void show(){
    if(parent == null){
      translate(width/2,height/2);
    }else{
      translate(parent.pos.x,parent.pos.y);
    }
    
    fill(col);
    ellipse(pos.x, pos.y, size, size);
  }
  
  void update(){
    // apply attraction
    if(parent != null){
      //this.applyForce(this.attract(parent));
    }
    
    /*
    // apply movement
    vel.add(acc);
    pos.add(vel);
    
    acc.mult(0);
    */
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acc.add(f);
  }
  
  PVector attract(Planet p) {
    PVector f = PVector.sub(p.pos, this.pos);
    float distance = f.mag();

    distance = constrain(distance,5.0,25.0);
 
 
    f.normalize();
    float strength = (0.4f * p.mass * mass) / (distance * distance);
    f.mult(strength);
    return f;
  }
  
}