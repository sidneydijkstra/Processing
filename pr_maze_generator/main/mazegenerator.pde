class MazeGenerator{
  MazeGenerator(){
   
  }
  
  void generate(Grid grid){
    // get cell grid
    Cell[] cellGrid = grid.getAllCells();
    
    // the path that the algerotim took
    ArrayList<Cell> path = new ArrayList<Cell>();
    
    // set top left cell to current cell
    Cell currentCell = cellGrid[0];
    path.add(currentCell);
    
    grid.update();
    
    while(path.size() > 0){
      println("pop");
      
      // get a random neighbour from current cell
      Cell neighbour = grid.getRandomNeighbour(currentCell);
      println(neighbour);
      
      // check if current cell has an neighbour
      if(neighbour != null){
        
        // open walls between cells
        grid.openWallBetweenCells(currentCell, neighbour);
        
        // set neighbour to current cell and set it to visited
        currentCell = neighbour;
        currentCell.visited = true;
        
        // add current cell to path
        path.add(currentCell);
        
      }else{
        path.remove(path.size()-1);
        if(path.size() != 0){
          currentCell = path.get(path.size());
        }
      }
    }
    
  }
  
}