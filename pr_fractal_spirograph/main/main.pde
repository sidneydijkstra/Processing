
Group group;

void setup(){
  size(400, 400);
  
  // amount of circle's | start size of circle | speed value (has to be < 0) | resolution
  group = new Group(10, 150, -4, 10);
}

void draw(){
  background(51);
  
  // update calles per update
  group.update(30);
  group.show();
}