
int gridSize = 25;
Cell[] grid;

Cell current;
ArrayList<Cell> stack = new ArrayList<Cell>();

void setup(){
  size(800,800);
  
  grid = new Cell[gridSize*gridSize];
  
  for(int i = 0; i < grid.length; i++){
    grid[i] = new Cell(i % gridSize, (i / gridSize)%gridSize);
    println("y: " + ((i / gridSize)%gridSize) + " x: " + (i % gridSize));
  }
  
  stack = new ArrayList<Cell>();
  current = grid[0];
  current.visited = true;
  
}

void draw(){
  background(200);
  frameRate(1000);
  
  for(int i = 0; i < grid.length; i++){ 
    grid[i].show();
  }
  
  current.highlight();
  
  Cell next = checkNeighbour(current);
  if(next != null){
    current.openWalls(next);
    stack.add(current);
    next.visited = true;
    current = next;
  }else{
    if(stack.size()-2 <= 0){
      current = stack.get(0);
    }else{
      current = stack.get(stack.size()-2);
      stack.remove(stack.size()-1);
    }
  }
  
}










int index(int x, int y){
  if(x < 0 || x > gridSize-1 || y < 0 || y > gridSize-1){
    return -1;
  }
  
  int id = x + y * gridSize;
  return id;
}

// get random neighbour
Cell checkNeighbour(Cell _cell){
  ArrayList<Cell> neighbour = new ArrayList<Cell>();
  
  int top = index(_cell.x, _cell.y - 1);
  if(top != -1 && !grid[top].visited){
    neighbour.add(grid[top]);
  }
  
  int right = index(_cell.x + 1, _cell.y);
  if(right != -1 && !grid[right].visited){
    neighbour.add(grid[right]);
  }
  
  int bottom = index(_cell.x, _cell.y + 1);
  if(bottom != -1 && !grid[bottom].visited){
    neighbour.add(grid[bottom]);
  }
  
  int left = index(_cell.x - 1, _cell.y);
  if(left != -1 && !grid[left].visited){
    neighbour.add(grid[left]);
  }
  
  if(neighbour.size() <= 0){
    return null;
  }else{
    return neighbour.get(floor(random(0, neighbour.size())));
  }
  
}