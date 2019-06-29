import java.util.Random;

public enum Mode{
  FLAG,
  POP
}

public class Task{
  Node node;
  Mode mode;
  public Task(Node _node, Mode _mode){ node = _node; mode = _mode; }
}

class Field{
  
  Node[][] grid;
  
  int sizeX;
  int sizeY;
  int mineCount;
  
  boolean gameOver;
  
  public Field(int _sizeX, int _sizeY, int _mineCount){
    sizeX = _sizeX;
    sizeY = _sizeY;
    mineCount = _mineCount;
    
    gameOver = false;
    
    prepareField();
  }
  
  void show(){
    for(int i = 0; i < sizeX; i++){
      for(int j = 0; j < sizeY; j++){
        if(!gameOver)
          grid[i][j].show();
         else
          grid[i][j].peek();
      }
    }
  }
  
  void update(){
    if(gameOver && key == 'R'){
      reset();
    }
  }
  
  // reset the field
  void reset(){
    prepareField();
  }
  
  // prepare the grid (create tiles, set position, set mines, set numbers)
  void prepareField(){
    grid = new Node[sizeX][];
    
    PVector nodeSize = new PVector(width/sizeX, height/sizeY);
    
    // create grid
    for(int i = 0; i < sizeX; i++){
      Node[] tempGrid = new Node[sizeY];
      for(int j = 0; j < sizeY; j++){
        PVector position = new PVector(nodeSize.x * i, nodeSize.y * j);
        tempGrid[j] = new Node(position, nodeSize, new PVector(i, j));
      }
      grid[i] = tempGrid;
    }
    
    // spawn mines
    Node[] tempGrid = new Node[sizeX*sizeY];
    int count = 0;
    for(int i = 0; i < sizeX; i++){
      for(int j = 0; j < sizeY; j++){
        tempGrid[count] = grid[i][j];
        count++;
      }
    }
    
    // randomize array
    Random rng = new Random();
    for (int i = tempGrid.length; i > 1; i--) {
      int j = rng.nextInt(i);
   
      Node tmp = tempGrid[j];
      tempGrid[j] = tempGrid[i-1];
      tempGrid[i-1] = tmp;
    }
    
    for(int i = 0; i < mineCount; i++){
      tempGrid[i].isMine = true;
    }
    
    // set number for grid
    for(int i = 0; i < sizeX; i++){
      for(int j = 0; j < sizeY; j++){
        if(!grid[i][j].isMine){
          grid[i][j].surroundedMines = getNeighboursMineCount(i, j);
        }
      }
    }
  }
  
  // get neighbours mine count
  int getNeighboursMineCount(int _x, int _y){
    int count = 0;
    for(int i = _x-1; i <= _x+1; i++){
      for(int j = _y-1; j <= _y+1; j++){
        if(i < 0 || i > sizeX-1 || j < 0 || j > sizeY-1){
          continue;
        }
        
        if(grid[i][j].isMine){
          count++;
        }
      }
    }
    return count;
  }
  
  // get neighbours in list function
  ArrayList<Node> getNeighbours(Node _node){
    ArrayList<Node> tempList = new ArrayList<Node>();
    int x = _node.gridX;
    int y = _node.gridY;
    
    for(int i = x-1; i <= x+1; i++){
      for(int j = y-1; j <= y+1; j++){
        if(i < 0 || i > sizeX-1 || j < 0 || j > sizeY-1 || i == x && j == y 
        || i == x+1 && j == x+1 || i == x-1 && j == x-1 || i == x+1 && j == x-1 || i == x-1 && j == x+1){
          continue;
        }
        
        tempList.add(grid[i][j]);
      }
    }
    return tempList;
  }
  
  // node pop ai
  void popNode(Node _node){
    if(_node.isMine){ //<>//
      gameOver = true;
      return;
    }
    
    if(_node.surroundedMines > 0){
      _node.open();
      return;
    }
    
    ArrayList<Node> openNode = new ArrayList<Node> ();
    ArrayList<Node> path = new ArrayList<Node> ();
    
    openNode.add(_node);
    _node.visited = true;
    
    while(openNode.size() > 0){
      Node currentNode = openNode.get(openNode.size()-1);
      ArrayList<Node> neighbours = getNeighbours(currentNode);
      
      // check neighbours for path or openNode node
      for(int i = 0; i < neighbours.size(); i++){
        Node n = neighbours.get(i);
        
        if(n.visited){
          continue;
        }
        
        if(n.surroundedMines == 0){
          openNode.add(n);
          n.visited = true;
        }else{
          path.add(n);
        }
      }
      
      path.add(currentNode);
      openNode.remove(currentNode);
    }
    
    for(int i = 0; i < path.size(); i++){
      Node n = path.get(i);
      n.open();
    }
  }
  
  // click for user
  void click(){
    int x = (mouseX - mouseX % sizeX) / sizeX;
    int y = (mouseY - mouseY % sizeY) / sizeY;
    
    if(mouseButton == LEFT){
      popNode(grid[x][y]);
    }
    else if(mouseButton == RIGHT){
      grid[x][y].flag();
    }
  }
  
  // click for ai
  void click(Task _task){
    if(_task.mode == Mode.POP){ //<>//
      popNode(_task.node);
    }
    else if(_task.mode == Mode.FLAG){
      _task.node.flag();
    }
  }
  
  // click for manual and ai
  void click(int _x, int _y){
    if((mouseButton == LEFT)){
      popNode(grid[_x][_y]);
    }
    else if(mouseButton == RIGHT){
      grid[_x][_y].flag();
    }
  }
  
  int getOpenTileAmount(){
    int count = 0;
    for(int i = 0; i < sizeX; i++){
      for(int j = 0; j < sizeY; j++){
        if(grid[i][j].isOpen){
          count++;
        }
      }
    }
    return count;
  }
  
  PVector getRandomGridPosition(){
    return new PVector(floor(random(0, sizeX)), floor(random(0, sizeY)));
  }
}