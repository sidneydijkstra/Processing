static int uniqueID;
Field _field;

void setup(){
  uniqueID = 0;  
  
  size(600, 600);
  _field = new Field();
}

void draw(){
  background(255);
  _field.update();
  _field.show();
}

static int generateUniqueID(){
  uniqueID++;
  return uniqueID;
}