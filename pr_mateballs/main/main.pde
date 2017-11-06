

Blob[] blobs = new Blob[5]; // normal = 5

void setup(){
  size(600, 600);
  colorMode(HSB);
  
  for(int i = 0; i < blobs.length; i++){
    blobs[i] = new Blob((int)random(width),(int)random(height));
  }
}

void draw(){
  loadPixels();
  
  for (int x = 0; x < width; x++){
    for (int y = 0; y < height; y++){
      int index = x + y * width;
      float sum = 0;
      for(int i = 0; i < blobs.length; i++){
        sum += 200 * blobs[i].r / dist(x, y, blobs[i].pos.x, blobs[i].pos.y);
      }
      pixels[index] = color(sum); // normal = sum, 255, 255
    }
  }
  
  updatePixels();
  
  for(int i = 0; i < blobs.length; i++){
    blobs[i].update();
    //blobs[i].show();
  }
  
}