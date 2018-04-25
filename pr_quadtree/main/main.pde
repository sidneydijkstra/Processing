
QuadTree qTree;

ArrayList<Point> list;
Rectangle box;

int searchCount;

void setup(){
  size(600, 600);
  
  qTree = new QuadTree(new Rectangle(new PVector(width/2, height/2), 600));
  box = new Rectangle(new PVector(width/2, height/2), 100);
  
  list = new ArrayList<Point>();
  for(int i = 0; i < 1000; i++){
    Point temp = new Point(new PVector(random(width), random(height)), 10);
    list.add(temp);
    qTree.insert(temp);
  }
}

void draw(){
  background(0);
  
  searchCount = 0;
  
  // draw quad tree
  qTree.show();
  
  // move and draw box
  box.center = new PVector(mouseX, mouseY);
  noStroke();
  stroke(0, 200, 0);
  rect(box.center.x, box.center.y, box.size, box.size);
  
  // search points inside of box
  ArrayList<Rectangle> foundList = qTree.query(box);
  for(int i = 0; i < foundList.size(); i++){
    Point temp = (Point)foundList.get(i);
    temp.inBox = true;
  }
  
  // draw points
  for(int i = 0; i < list.size(); i++){
    Point temp = list.get(i);
    temp.show();
    
    temp.inBox = false;
  }
  
  print("Current search: " + searchCount + ": Would have Searched: " + list.size() + "\n");
}