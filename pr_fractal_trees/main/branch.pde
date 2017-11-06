class Branch{
  
  PVector begin;
  PVector end;
  
  boolean grown;
  
  Branch(PVector _begin, PVector _end){
    begin = _begin;
    end = _end;
    
    grown = false;
  }
  
  void show(){
    stroke(random(255),random(255),random(255));
    strokeWeight(3);
    line(begin.x, begin.y, end.x, end.y);
  }
  
  void jitter(){
    this.end.x += random(-1,1);
    this.end.y += random(-1,1);
  }
  
  Branch branchLeft(){
    PVector dir = PVector.sub(end, begin);
    dir.rotate(-PI / 4);
    dir.mult(0.7);
    PVector newEnd = PVector.add(end, dir);
    return new Branch(end, newEnd);
  }
  
  Branch branchRight(){
    PVector dir = PVector.sub(end, begin);
    dir.rotate(PI / 4);
    dir.mult(0.7);
    PVector newEnd = PVector.add(end, dir);
    return new Branch(end, newEnd);
  }
  
}