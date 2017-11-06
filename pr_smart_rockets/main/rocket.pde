class Rocket{
  
  // variables
  PVector pos;
  PVector vel;
  PVector acc;
  
  DNA dna;
  
  float fitness = 0;
  float finishTime = 0;
  
  Boolean complete = false;
  Boolean crash = false;
  
  // line drawing
  ArrayList<PVector> knownPositions = new ArrayList<PVector>();
  
  // constructor
  Rocket(DNA _dna){
    pos = new PVector(width/2, height);
    vel = new PVector();
    acc = new PVector();
    
    if(_dna != null){
      dna = _dna;
    }else{
      dna = new DNA(null);
    }
    
    knownPositions.add(pos); 
  }
  
  // update function
  void update(){
    
    if(pos.dist(target) < 15){
      complete = true;
      finishTime = lifetime;
    }
    
    if(pos.x > width || pos.x < 0 || pos.y < 0 || pos.y > height || block.checkCollision(pos)){
      crash = true;
    }
    
    if(!complete && !crash){
      vel.add(acc);
      pos.add(vel);
      acc.mult(0);
      vel.limit(4);
    }
  }
  
  // draw function
  void show(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.heading());
    rectMode(CENTER);
    
    pushStyle();
    noStroke();
    fill(255, 60);
    
    rect(0, 0, 30, 10);
    
    popMatrix();
    popStyle();
  }
  
  void drawLine(){
    knownPositions.add(pos);
    pushStyle();
    stroke(0, 255, 0);
    strokeWeight(0.5);
    for(int i = 0; i < knownPositions.size() - 1; i++){
      line(knownPositions.get(i).x,knownPositions.get(i).y,knownPositions.get(i+1).x,knownPositions.get(i+1).y);
    }
    popStyle();
  }
  
  void applyForce(PVector _force){
    acc.add(_force);
  }
  
  void calcFitness(){
    float dis = pos.dist(target.copy());
    this.fitness = map(dis, 0, width, width, 0);
    
    if(complete){
      this.fitness += maxLifetime - lifetime;
      this.fitness *= 5;
    }
    
    if(crash){
      this.fitness /= 5;
    }
  }
}