class Table{
  
  int _size;
  int _w;
  
  Tile[][] grid;
  Tile newTile;
  
  public Table(int _size, int _w){
    this._size = _size;
    this._w = _w;
    
    this.createGrid(_size);
    this.addNumber();
    this.addNumber();
  }
  
  private void createGrid(int size){
    grid = new Tile[size][size];
    for(int i = 0; i < size; i++){
      Tile[] temp = new Tile[size];
      for(int j = 0; j < size; j++){
        temp[j] = new Tile();
      }
      grid[i] = temp;
    }
  }
  
  public void addNumber(){
    ArrayList<Tile> list = new ArrayList<Tile>();
    
    for(int i = 0; i < _size; i++){
      for(int j = 0; j < _size; j++){
        if(grid[i][j].isZero()){
          list.add(grid[i][j]);
        }
      }
    }
    
    if(list.isEmpty()){
      return;
    }
    
    int rand = floor(random(list.size()));
    Tile t = list.get(rand);
    int num = random(1) > 0.5f ? 2 : 4;
    t.setNumber(num);
    
    newTile = t;
  }
  
  public void move(int dir){
    switch(dir){
      case 0: // left
        this.moveLeft();
        break;
      case 1: // up
        this.rotateLeft();
        this.moveLeft();
        this.rotateRight();
        break;
      case 2: // right
        this.rotateLeft();
        this.rotateLeft();
        this.moveLeft();
        this.rotateRight();
        this.rotateRight();
        break;
      case 3: // down
        this.rotateRight();
        this.moveLeft();
        this.rotateLeft();
        break;
    }
    
    addNumber();
  }
  
  private void moveLeft(){
    for(int i = 0; i < _size; i++){
      ArrayList<Tile> temp = new ArrayList<Tile>();
      for(int j = 0; j < _size; j++){
        if(!grid[i][j].isZero()){
          temp.add(grid[i][j]);
        }
      }
      
      Tile[] t = new Tile[_size];
      for(int j = 0; j < _size; j++){
        if(j < temp.size()){
          t[j] = temp.get(j);
        }else{
          t[j] = new Tile();
        }
      }
      grid[i] = t;
      
    }
    
    moveCheck();
  }
  
  private void rotateLeft(){
    Tile[][] tempgrid = new Tile[_size][_size];
    for(int i = 0; i < _size; i++){
      for(int j = 0; j < _size; j++){
        tempgrid[(_size-1) - j][i] = grid[i][j];
      }
    }
    grid = tempgrid;
  }
  
  private void rotateRight(){
    Tile[][] tempgrid = new Tile[_size][_size];
    for(int i = 0; i < _size; i++){
      for(int j = 0; j < _size; j++){
        tempgrid[j][(_size-1) - i] = grid[i][j];
      }
    }
    grid = tempgrid;
  }
  
  private void moveCheck(){
    for(int i = 0; i < _size; i++){
      Tile currentTile = null;
      for(int j = 0; j < _size; j++){
        Tile t = grid[i][j];
        if(!t.isZero()){
          if(currentTile != null && currentTile.canCombine(t)){
            currentTile.combine(t);
            t.destroy();
            
            currentTile = null;
          }else{
            currentTile = t;
          }
        }
      }
    }
  }
  
  public void update(){
  
  }
  
  public void show(){
    for(int i = 0; i < _size; i++){
      for(int j = 0; j < _size; j++){
        // box
        fill(255);
        stroke(0);
        strokeWeight(5);
        rect(j * _w, i * _w, _w, _w);
        
        // text
        if(!grid[i][j].isZero()){
          
          if(newTile == grid[i][j]){
            fill(100);
          }else{
            fill(0);
          }
          
          
          textSize(64);
          textAlign(CENTER);
          String num = str(grid[i][j].getNumber());
          text(num, j * _w + _w/2, (i * _w - _w/4) + _w);
        }
      }
    }
  }
  
}