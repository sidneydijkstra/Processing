
PVector a;
PVector b;
PVector c;

PVector r;

void setup(){
  size(800, 800);
  
  a = new PVector(random(width), random(height));
  b = new PVector(random(width), random(height));
  c = new PVector(random(width), random(height));
  
  background(0);
  stroke(255);
  strokeWeight(1);
  point(a.x, a.y);
  point(b.x, b.y);
  point(c.x, c.y);
  
  r = new PVector(random(width), random(height));
}

void draw(){
  
  for(int i = 0; i < 500; i++){
    int random = floor(random(3));
    
    if(random == 0){
      stroke(0, 255, 255);
      r = PVector.lerp(r, a, 0.5);
    }else if(random == 1){
      stroke(255, 0, 255);
      r = PVector.lerp(r, b, 0.5);
    }else if(random == 2){
      stroke(255, 255, 0);
      r = PVector.lerp(r, c, 0.5);
    }
    
    point(r.x, r.y);
  }
  
}

void keyPressed(){
  a = new PVector(random(width), random(height));
  b = new PVector(random(width), random(height));
  c = new PVector(random(width), random(height));
  
  background(0);
  stroke(255);
  strokeWeight(1);
  point(a.x, a.y);
  point(b.x, b.y);
  point(c.x, c.y);
  
  r = new PVector(random(width), random(height));
}