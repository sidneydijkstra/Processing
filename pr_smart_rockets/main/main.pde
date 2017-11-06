
Population population;

int maxPopulation = 100;
int maxLifetime = 300;
int lifetime = 0;

PVector target;
PVector startpos;

Blockage block;
  
void setup(){
  size(800, 450);
  population = new Population();
  
  target = new PVector(width/2, 30);
  startpos = new PVector(width/2, height);
  
  block = new Blockage(200, 200, 400, 20);
}

void draw(){
  background(100,100,100);
  if(lifetime >= maxLifetime){
    population.evaluate();
    population.selection();
    lifetime = 0;
  }
  population.run();
  lifetime++;
  
  // draw target
  ellipse(target.x, target.y, 30, 30);
  block.show();
  
  // print lifetime
  //println(lifetime);
}