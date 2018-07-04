class Galaxy{
  
  ArrayList sols = new ArrayList();
  SolarSystem loadedSol = null;
  Boolean loadSol = false;
  
  Galaxy(float maxDis, color[] colors){
    
    PVector point = new PVector(width/2, height/2);
    
    for(int x = 0; x < width; x++){
      for(int y = 0; y < height; y++){
        if(dist(x, y, point.x, point.y) < maxDis && !randomBool(maxDis, dist(x, y, point.x, point.y))){
          color col = colors[(int)random(colors.length)];
          sols.add(new SolarSystem(x, y, col, 5));
        }
      }
    }
  }
  
  void show(){
    if(loadedSol != null){ // on display solarsystem
      
      loadedSol.show();
      loadedSol.update();
      
    }else{ // on display full galaxy
      loadPixels();
      for(int i = 0; i < sols.size(); i++){
        SolarSystem gal = (SolarSystem)sols.get(i);
        int index = gal.getX() + gal.getY() * width;
        pixels[index] = gal.getColor();
        
        // check if hover on galaxy
        if(mouseX == gal.getX() && mouseY == gal.getY() && loadSol){ // no work
          textSize(32);
          fill(0, 102, 153);
          text("you hover galaxy you good", 10, 30);
          
          loadedSol = gal;
        }else if(mouseX == gal.getX() && mouseY == gal.getY()){
          print("hover");
        }
      }
      
      
      updatePixels();
    }
  }
  
  void update(){
  
  }
  
  boolean randomBool(float max, float change){
    if(random(max) < change){
      return true;
    }
    return false;
  }
 
}