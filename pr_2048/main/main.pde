
static class Direction{
  static int left = 0;
  static int up = 1;
  static int right = 2;
  static int down = 3;
}

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
  if(key == 'a'){
    table.move(Direction.left);
  }else if(key == 'w'){
    table.move(Direction.up);
  }else if(key == 'd'){
    table.move(Direction.right);
  }else if(key == 's'){
    table.move(Direction.down);
  }
}