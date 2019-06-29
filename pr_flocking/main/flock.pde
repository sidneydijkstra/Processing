class Flock{

  Boid[] boids;
  
  public Flock(int _size, color _boidsColor){
    boids = new Boid[_size];
    for(int i = 0; i < boids.length; i++){
      boids[i] = new Boid(_boidsColor);
    }
  }
  
  void update(Boid[] _otherFlockBoids){
    for(int i = 0; i < boids.length; i++){
      boids[i].edge();
      boids[i].flock(boids, _otherFlockBoids);
      boids[i].update();
    }
  }
  
  void show(){
    for(int i = 0; i < boids.length; i++){
      boids[i].show();
    }
  }

}