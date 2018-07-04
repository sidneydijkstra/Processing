class Circle{
  
  PVector position;
  float radius;
  float speed;
  
  public Circle(float r){
    position = new PVector();
    radius = r;
  }
  public Circle(PVector p, float r){
    position = p;
    radius = r;
  }
  public Circle(float x, float y, float r){
    position = new PVector(x, y);
    radius = r;
  }
  
  public void show(){
    stroke(255);
    noFill();
    ellipse(position.x, position.y, radius, radius);  
  }
  
  public void rotateRound(PVector p, float r, float a, float s){
    a *= s;
    float rDiv = r + radius/2;
    position.x = p.x + rDiv * cos(a);
    position.y = p.y + rDiv * sin(a);
  }
  
  public void rotateRound(Circle c, float a, float s){
    a *= s;
    float rDiv = c.radius/2 + radius/2;
    position.x = c.position.x + rDiv * cos(a);
    position.y = c.position.y + rDiv * sin(a);
  }

}