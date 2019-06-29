class Boid{
  color boidColor;
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  int maxForce;
  int maxSpeed;
  
  public Boid(color _boidColor){
    boidColor = _boidColor;
    
    position = new PVector(random(width), random(height));
    velocity = PVector.random2D();//new PVector();
    velocity.setMag(random(2, 4));
    acceleration = new PVector();
    
    maxForce = 1;
    maxSpeed = 4;
  }
  
  // check edge collision
  void edge(){
    if(position.x >= width){
      position.x = 0;
    }else if(position.x <= 0){
      position.x = width;
    }
    if(position.y >= height){
      position.y = 0;
    }else if(position.y <= 0){
      position.y = height;
    }
  }
  
  void flock(Boid[] _boids, Boid[] _otherFlockBoids){
    PVector alignForce = align(_boids);
    PVector separatForce = separat((Boid[])concat(_boids, _otherFlockBoids)); // <-- separat from all boids on map
    PVector cohesionForce = cohesion(_boids);
    
    alignForce.mult(1.0f);
    separatForce.mult(1.2f);
    cohesionForce.mult(1.0f);
    
    acceleration.add(alignForce);
    acceleration.add(separatForce);
    acceleration.add(cohesionForce);
  }
  
  void update(){
    position.add(velocity);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    acceleration.mult(0);
  }
  
  // align with other boids
  PVector align(Boid[] _boids){
    float perceptionRange = 50f;
    PVector steering = new PVector();
    int totalBoids = 0;
    
    for(int i = 0; i < _boids.length; i++){
      float distance = PVector.dist(position, _boids[i].position);
      if(_boids[i] != this && distance <= perceptionRange){
        steering.add(_boids[i].velocity);
        totalBoids++;
      }
    }
    
    if(totalBoids > 0){
      steering.div(totalBoids);
      steering.setMag(maxSpeed);
      steering.sub(this.velocity);
      steering.limit(maxForce);
    }
    
    return steering;
  }
  
  // separat from other boids (dont collide with other boids)
  PVector separat(Boid[] _boids){
    float perceptionRange = 50f;
    PVector steering = new PVector();
    int totalBoids = 0;
    
    for(int i = 0; i < _boids.length; i++){
      float distance = PVector.dist(position, _boids[i].position);
      if(_boids[i] != this && distance <= perceptionRange){
        PVector diff = PVector.sub(position, _boids[i].position);
        diff.div(pow(distance, 2));
        steering.add(diff);
        totalBoids++;
      }
    }
    
    if(totalBoids > 0){
      steering.div(totalBoids);
      steering.setMag(maxSpeed);
      steering.sub(this.velocity);
      steering.limit(maxForce);
    }
    
    return steering;
  }
  
  // move to center of close boids
  PVector cohesion(Boid[] _boids){
    float perceptionRange = 100f;
    PVector steering = new PVector();
    int totalBoids = 0;
    
    for(int i = 0; i < _boids.length; i++){
        float distance = PVector.dist(position, _boids[i].position);
        if(_boids[i] != this && distance <= perceptionRange){
          steering.add(_boids[i].position);
          totalBoids++;
        }
      }
      
      if(totalBoids > 0){
        steering.div(totalBoids);
        steering.sub(this.position);
        steering.setMag(maxSpeed);
        steering.sub(this.velocity);
        steering.limit(maxForce);
      }
      
      return steering;
  }
  
  void show(){
    stroke(0, 255, 0);
    strokeWeight(2);
    line(position.x, position.y, (position.x + velocity.x * (maxSpeed * 2)), position.y + velocity.y * (maxSpeed * 2));
    
    stroke(boidColor);
    strokeWeight(10);
    point(position.x, position.y);
  }

}