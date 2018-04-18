class Point extends Rectangle{
  
  Boolean inBox;
  
  Point(PVector _center, float _size){
    super(_center, _size);
    
    inBox = false;
  }
  
  public void show(){
    if(!inBox){
      fill(255,255,255);
    }else{
      fill(0,255,0);
    }
    
    noStroke();
    ellipse( center.x, center.y, size, size);
  }
}