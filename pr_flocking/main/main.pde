

Flock[] _flocks;
Boid[] _allBoids;

void setup(){
  size(1000, 800);
  _allBoids = new Boid[0];
  
  _flocks = new Flock[5];
  for(int i = 0; i < _flocks.length; i++){
    _flocks[i] = new Flock(40, color(random(255),random(255),random(255)));
    _allBoids = (Boid[])concat(_allBoids, _flocks[i].boids);
  }
}

void draw(){
  background(0);
  for(int i = 0; i < _flocks.length; i++){
    _flocks[i].update(_allBoids);
    _flocks[i].show();
  }
  
  /*
  for(int i = 0; i < 1; i++){
    for(int j = 0; j < _allBoids.length; j++){
      if(_allBoids[i] == _allBoids[j]){
        continue;
      }
      
      stroke(0, 255, 0);
      strokeWeight(2);
      line(_allBoids[i].position.x, _allBoids[i].position.y, _allBoids[j].position.x, _allBoids[j].position.y);
    }
  }
  */
}