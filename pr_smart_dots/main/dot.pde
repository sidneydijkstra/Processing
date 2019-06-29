class Dot{
  int id;
  
  PVector position;
  PVector direction;
  PVector size;
  
  float moveSpeed;
  float seeRange;
  
  public Dot(){
    // set id
    id = generateUniqueID();
    
    // set position direction and size
    position = new PVector(width/2, height/2);
    direction = PVector.random2D();
    size = new PVector(20, 20);
    
    // set changable variables
    moveSpeed = random(1.0, 2.0);
    seeRange = random(50, 100);
  }
  
  void update(Dot[] _dots){
    PVector pos = direction.mult(moveSpeed);
    position.add(pos);
    
    if(!checkVision(_dots))
      randomSmootheDirection();
      
    checkBorders();
  }
  
  void show(){
    strokeWeight(0);
    
    // draw range
    fill(0, 170, 0, 100);
    ellipse(position.x, position.y, seeRange*2, seeRange*2);
    
    // draw ellipse
    fill(0, 0, 170);
    ellipse(position.x, position.y, size.x, size.y);
  }
  
  Boolean checkVision(Dot[] _dots){
    
    for(int i = 0; i < _dots.length; i++){
      if(_dots[i].id == id){
        continue;
      }
      
      if(PVector.dist(position, _dots[i].position) <= seeRange){
        PVector desiredDir = PVector.sub(position, _dots[i].position);
        desiredDir.normalize();
        desiredDir.mult(moveSpeed);
        
        direction = PVector.sub(position ,desiredDir);
        direction.limit(1);
        return true;
      }
      
    }
    
    return false;
  }
  
  void checkBorders(){
    if(position.x <= 0 || position.x >= width){
      direction.x = -direction.x;
    }
    
    if(position.y <= 0 || position.y >= height){
      direction.y = -direction.y;
    }
  }
  
  void randomSmootheDirection(){
    direction.x += random(-0.3, 0.3);
    direction.y += random(-0.3, 0.3);
    direction.limit(1);
  }
}