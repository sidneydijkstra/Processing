class Table{
  
  int _size;
  int _w;
  
  Tile[][] grid;
  
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
  }
  
  public void moveLeft(){
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
    
    addNumber();
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
          fill(0);
          textSize(64);
          textAlign(CENTER);
          String num = str(grid[i][j].getNumber());
          text(num, j * _w + _w/2, (i * _w - _w/4) + _w);
        }
        
      }
    }
  }
  
}