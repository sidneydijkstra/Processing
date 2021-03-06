class Rectangle{
  
  PVector center;
  float size;
  
  public Rectangle(PVector _center, float _size){
    this.center = _center;
    this.size = _size;
  }
  
  public Boolean contains(PVector point){
    return (point.x >= this.center.x - this.size/2 &&
            point.x <= this.center.x + this.size/2 &&
            point.y >= this.center.y - this.size/2 &&
            point.y <= this.center.y + this.size/2);
  }
  
  public Boolean contains(Rectangle other){
    PVector point = other.center;
    return (point.x >= this.center.x - this.size/2 &&
            point.x <= this.center.x + this.size/2 &&
            point.y >= this.center.y - this.size/2 &&
            point.y <= this.center.y + this.size/2);
  }
  
  public Boolean intersects(Rectangle other){
    if(other.center.x - other.size > this.center.x + this.size/2 ||
       other.center.x + other.size < this.center.x - this.size/2 ||
       other.center.y - other.size < this.center.y + this.size/2 ||
       other.center.y + other.size < this.center.y - this.size/2){
         return true;
    }
    return false;
  }
  
}