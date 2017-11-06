
PVector point;
color[] colors;

ArrayList galaxys = new ArrayList();

void setup(){
  size(600,600);
  
  point = new PVector(300,300);
  
  colors = new color[4];
  colors[0] = color(0,58,101);
  colors[1] = color(0,144,133);
  colors[2] = color(255,255,255);
  colors[3] = color(150,0,136);
  
  /*
  colors = new color[5];
  colors[0] = color(5,25,64);
  colors[1] = color(10,40,99);
  colors[2] = color(48,10,99);
  colors[3] = color(79,10,99);
  colors[4] = color(99,10,68);
  */
  
  float maxD = 300;
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){
      if(dist(x, y, point.x, point.y) < maxD && !randomBool(maxD, dist(x, y, point.x, point.y))){
        color col = colors[(int)random(colors.length)];
        galaxys.add(new Galaxy(x, y, col));
      }
    }
  }
}
 
void draw(){
  background(0);
  
  loadPixels();
  
  for(int i = 0; i < galaxys.size(); i++){
    Galaxy gal = (Galaxy)galaxys.get(i);
    int index = gal.getX() + gal.getY() * width;
    pixels[index] = gal.getColor();
    
    // check if hover on galaxy
    if(mouseX == gal.getX() && mouseY == gal.getY()){ // no work
      textSize(32);
      fill(0, 102, 153);
      text("you hover galaxy you good", 10, 30); 
    }
  }
  
  //print("   X: " + mouseX + " Y: " + mouseY);
  
  updatePixels();
}

boolean randomBool(float max, float change){
  if(random(max) < change){
    return true;
  }
  return false;
}