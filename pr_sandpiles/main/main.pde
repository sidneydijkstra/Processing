
int[][] sandpiles;

void setup(){
  size(400,400);
  sandpiles = new int[width][height];
  
  sandpiles[width/2][height/2] = 100000;
}

void draw(){
  loadPixels();
  
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){
      int num = sandpiles[x][y];
      
      color col = color(194, 178, 128);
      
      if(num == 1){
        col = color(202, 188, 145);
      }else if(num == 2){
        col = color(194, 178, 128);
      }else if(num == 3){
        col = color(166, 145, 80);
      }else if(num >= 4){
        col = color(114, 100, 55);
      }
      
      pixels[x+y*width] = col;
    }
  }
  
  updatePixels();
  
  for(int i = 0; i < 100; i++){
    topple();
  }
}

void mouseClicked() {
  sandpiles[mouseX][mouseY] = 100000;
}

void topple(){
  int[][] nextpiles = new int[width][height];
  
  
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){
      if(sandpiles[x][y] < 4){
        nextpiles[x][y] = sandpiles[x][y];
      }
    }
  }
  
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){
      if(sandpiles[x][y] >= 4){
        nextpiles[x][y] += sandpiles[x][y] - 4;
        
        if(x+1 < width)
          nextpiles[x+1][y]++;
        if(x-1 > 0)
          nextpiles[x-1][y]++;
          
        if(y+1 < height)
          nextpiles[x][y+1]++;
        if(y-1 > 0)
          nextpiles[x][y-1]++;
      }
    }
  }
  
  sandpiles = nextpiles;
}