

Field field;
MineSweeperAI mineAI;

void setup(){
  size(400, 400);
  
  field = new Field(20, 20, 25);
  mineAI = new MineSweeperAI();
}

void draw(){
  background(255);
  
  field.show();
  mineAI.show(field);
  mineAI.reset(field);
}

void keyPressed(){
  if(key == 's'){
    field.click(mineAI.predict(field));
  }
}

void mouseClicked(){
  //field.click();
}