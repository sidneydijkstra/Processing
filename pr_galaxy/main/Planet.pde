class Planet{
  
  color col;
  PVector pos;
  float size;
  
  Planet(){
    col = color(random(255),random(255),random(255));
    pos = new PVector(width/2, height/2);
    size = random(50, 200);
  }
  
  void show(){
    fill(col);
    ellipse(pos.x, pos.y, size, size);
  }
  
  void update(){
  
  }
}