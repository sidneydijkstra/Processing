class Grid{
  
  Cell[] grid;
  int size;
  
  Grid(int _size){
    size = _size;
    grid = new Cell[size * size];
    for(int i = 0; i < size * size; i++){
      grid[i] = new Cell(floor(i/size), i%size);
    }
  }
  
  // update function
  void update(){
    for(int i = 0; i < grid.length; i++){
      grid[i].show();
    }
  }
  
  // get all cells
  Cell[] getAllCells(){
    return grid;
  }
  
  // get a cell
  Cell getCell(int _x, int _y){
    int pos = xyToNormal(_x,_y);
    if(pos > grid.length){
      return null;
    }
    return grid[pos];
  }
  
  Boolean canGetCell(int _x, int _y){
    int pos = xyToNormal(_x,_y);
    if(pos > grid.length){
      return false;
    }
    return true;
  }
  
  // get random neighbour
  Cell getRandomNeighbour(Cell _cell){
    ArrayList<Cell> neighbour = new ArrayList<Cell>();
    
    if(_cell.x + 1 <= gridSize && canGetCell(_cell.x + 1, _cell.y) && !getCell(_cell.x + 1, _cell.y).visited){
      neighbour.add(getCell(_cell.x + 1, _cell.y));
    }
    if(_cell.x - 1 >= 0 && canGetCell(_cell.x - 1, _cell.y) && !getCell(_cell.x - 1, _cell.y).visited){
      neighbour.add(getCell(_cell.x - 1, _cell.y));
    }
    if(_cell.y + 1 <= gridSize && canGetCell(_cell.x, _cell.y + 1) && !getCell(_cell.x, _cell.y + 1).visited){
      neighbour.add(getCell(_cell.x, _cell.y + 1));
    }
    if(_cell.y - 1 >= 0 && canGetCell(_cell.x, _cell.y - 1) && !getCell(_cell.x, _cell.y - 1).visited){
      neighbour.add(getCell(_cell.x, _cell.y - 1));
    }
    
    if(neighbour.size() <= 0){
      return null;
    }else{
      return neighbour.get(floor(random(0, neighbour.size())));
    }
    
  }
  
  // open wall between two cells
  void openWallBetweenCells(Cell _cellA, Cell _cellB){
    if(_cellA.y + 1 == _cellB.y){ // top
      _cellA.wTop = false;
      _cellB.wBottom = false;
    }
    if(_cellA.x + 1 == _cellB.x){ // right
      _cellA.wRight = false;
      _cellB.wLeft = false;
    }
    if(_cellA.y - 1 == _cellB.y){ // bottom
      _cellA.wBottom = false;
      _cellB.wTop = false;
    }
    
    if(_cellA.x - 1 == _cellB.x){ // left
      _cellA.wLeft = false;
      _cellB.wRight = false;
    }
  }
  
  // get array position from x and y
  int xyToNormal(int _x, int _y){
    return ((_y * gridSize) + _x) - 1;
  }
  
}