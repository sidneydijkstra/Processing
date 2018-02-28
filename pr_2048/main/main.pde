
Table table;

void setup(){
  size(400,400);
  
  table = new Table(4, 100);
}

void draw(){
  background(255);
  table.show();
}

void keyPressed(){
  table.moveLeft();
}