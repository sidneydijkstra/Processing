
Galaxy galaxy;

void setup(){
  size(600,600);
  
  color[] colors = new color[4];
  colors[0] = color(0,58,101);
  colors[1] = color(0,144,133);
  colors[2] = color(255,255,255);
  colors[3] = color(150,0,136);
  
  /*
  color[] colors = new color[5];
  colors[0] = color(5,25,64);
  colors[1] = color(10,40,99);
  colors[2] = color(48,10,99);
  colors[3] = color(79,10,99);
  colors[4] = color(99,10,68);
  */
  
  galaxy = new Galaxy(300, colors);
  
}
 
void draw(){
  background(0);
  
  galaxy.show();
}

void keyPressed(){
    if(key == 'x'){
      galaxy.loadSol = true;
    }else
    if(key == 'c'){
      galaxy.loadSol = false;
      galaxy.loadedSol = null;
    }
  }