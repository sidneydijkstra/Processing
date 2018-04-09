
QuadTree qTree;
Rectangle[] points;

void setup(){
  size(400, 400);
  
  qTree = new QuadTree(new Rectangle(new PVector(width/2, height/2), 400));
  
  points = new Rectangle[100];
  for(int i = 0; i < 100; i++){
    points[i] = new Rectangle(new PVector(random(width), random(height)), 10);
    qTree.insert(points[i]);
  }
}

void draw(){
  background(0);
  qTree.show();
  
  for(int i = 0; i < points.length; i++){
    fill(255,0,0);
    noStroke();
    ellipse(points[i].center.x,points[i].center.y, 10, 10);
  }
}