// class Cell
class Cell{
  
  // size
  int h;
  int w;
  
  // grid pos
  int y;
  int x;
  
  // scene pos
  int j;
  int i;
 
 // wall bools
  Boolean wTop;
  Boolean wRight;
  Boolean wBottom;
  Boolean wLeft;
  
  // visited variable
  Boolean visited;
  
  // constructor function
  Cell(int _cell, int _row){
    y = _row;
    x = _cell;
    
    h = height / gridSize;
    w = width / gridSize;
    
    j = y * h;
    i = x * w;
    
    wTop = true;
    wRight = true;
    wBottom = true;
    wLeft = true;
    
    visited = false;
  }
  
  // update function
  void update(){
  
  }
  
  // show function
  void show(){
    // draw quad
    pushStyle();
    noStroke();
    if(visited){
      fill(255);
    }else{
      fill(150);
    }
    rect(i, j, w, h);
    popStyle();
    
    // draw lines
    pushStyle();
    
    if(wTop){
      line(i,j, i + w, j);
    }
    if(wRight){
      line(i + w, j , i + w, j + h);
    }
    if(wBottom){
      line(i ,j + h, i + w, j + h);
    }
    if(wLeft){
      line(i,j, i, j + h);
    }
    
    popStyle();
  }
  
  void highlight(){
    pushStyle();
    noStroke();
    fill(0,220,0);
    rect(i, j, w, h);
    popStyle();
  }
  
  void openWalls(Cell _cell){
    if(this.y - _cell.y == 1){ // top
      this.wTop = false;
      _cell.wBottom = false;
    }
    if(this.x - _cell.x == -1){ // right
      this.wRight = false;
      _cell.wLeft = false;
    }
    if(this.y - _cell.y == -1){ // bottom
      this.wBottom = false;
      _cell.wTop = false;
    }
    
    if(this.x - _cell.x == 1){ // left
      this.wLeft = false;
      _cell.wRight = false;
    }
  }
  
}