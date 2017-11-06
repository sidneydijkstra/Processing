class Blockage{
  
  PVector pos;
  PVector size;
  
  Blockage(float px, float py, float sw, float sh){
    pos = new PVector(px, py);
    size = new PVector(sw, sh);
  }
  
  void show(){
    pushStyle();
    rectMode(CORNER);
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
  }
  
  Boolean checkCollision(PVector _pos){
    if(_pos.x > pos.x && _pos.x < pos.x + size.x && _pos.y > pos.y && _pos.y < pos.y + size.y){
      return true;
    }
    return false;
  }
  
}