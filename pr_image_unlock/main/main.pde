
PImage img;

Box b;

void setup(){
  size(800, 800);
  
  img = loadImage("image.jpg");
  img.resize(width,height);
  
  b = new Box(0,0,800,800, img.pixels);
}

void draw(){
  b.show();
  
}

void mouseMoved() {
  b.click(mouseX,mouseY);
}