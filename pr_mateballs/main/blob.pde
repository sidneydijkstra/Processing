class Blob{
  PVector pos;
  PVector vel;
  float r;
  
  Blob(int x, int y){
    pos = new PVector(x,y);
    r = random(20, 40); // normal = 20, 60
    
    vel = PVector.random2D();
    vel.mult(random(3,5));
    
  }
  
  void update(){
    pos.add(vel);
    
    if(pos.x < 0 || pos.x > width){
      vel.x *= -1;
    }
    if(pos.y < 0 || pos.y > height){
      vel.y *= -1;
    }
  }
  
  void show(){
    noFill();
    stroke(0);
    strokeWeight(4);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
  
}