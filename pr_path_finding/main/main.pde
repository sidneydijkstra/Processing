Map map;
AiManager AiManager;

Entity[] entitys;
int entityAmount = 5; 

void setup(){
  size(600,600);
  
  map = new Map(20,20);
  AiManager = new AiManager();
  
  entitys = new Entity[entityAmount];
  for(int i = 0; i < entityAmount; i++){
    entitys[i] = new Entity(i);
    AiManager.addAiListener(entitys[i]);
  }
}

void draw(){
  background(255);
  
  map.update();
  map.show();
  
  AiManager.update(map);
  AiManager.show();
}