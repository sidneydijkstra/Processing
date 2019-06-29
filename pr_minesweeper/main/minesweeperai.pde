
class MineSweeperAI{
  
  public MineSweeperAI(){
  }
  
  void show(Field _field){
    calculatePrecent(_field);
    for(int i = 0; i < _field.sizeX; i++){
      for(int j = 0; j < _field.sizeY; j++){
        _field.grid[i][j].debug();
      }
    }
  }
  
  void reset(Field _field){
    for(int i = 0; i < _field.sizeX; i++){
      for(int j = 0; j < _field.sizeY; j++){
        _field.grid[i][j].reset();
      }
    }
  }
  
  Task predict(Field _field){
    
    int openAmount =_field.getOpenTileAmount();
    if(openAmount < 50){
      PVector position = _field.getRandomGridPosition();
      return new Task(_field.grid[(int)position.x][(int)position.y], Mode.POP);
    }
    
    calculatePrecent(_field);
    
    for(int i = 0; i < _field.sizeX; i++){
      for(int j = 0; j < _field.sizeY; j++){
        if(!_field.grid[i][j].isFlag && !_field.grid[i][j].isOpen &&_field.grid[i][j].precent >= 8){
          return new Task(_field.grid[i][j], Mode.FLAG);
        }
      }
    }
    
    int lowestCount = 9; // 9 == max+1
    PVector lowestNodePosition = null;
    for(int i = 0; i < _field.sizeX; i++){
      for(int j = 0; j < _field.sizeY; j++){
        if(!_field.grid[i][j].isFlag && !_field.grid[i][j].isOpen &&_field.grid[i][j].precent < lowestCount){
          lowestCount = _field.grid[i][j].precent;
          lowestNodePosition = new PVector(i, j);
        }
      }
    }
    
    reset(_field);
    print("NODEPOSITION -> " + lowestNodePosition.toString());
    return new Task(_field.grid[(int)lowestNodePosition.x][(int)lowestNodePosition.y], Mode.POP);
  }
  
  void calculatePrecent(Field _field){
    for(int i = 0; i < _field.sizeX; i++){
      for(int j = 0; j < _field.sizeY; j++){
        if(_field.grid[i][j].isOpen && _field.grid[i][j].surroundedMines > 0){
          ArrayList<Node> neighbours = getNeighbours(_field.grid[i][j], _field);
          for(int k = 0; k < neighbours.size(); k++){
            Node tempNode = neighbours.get(k);
            if(!tempNode.isOpen){
              tempNode.precent++;
            }
          }
        }
      }
    }
  }
  
  // get neighbours in list function
  ArrayList<Node> getNeighbours(Node _node, Field _field){
    ArrayList<Node> tempList = new ArrayList<Node>();
    int x = _node.gridX;
    int y = _node.gridY;
    
    for(int i = x-1; i <= x+1; i++){
      for(int j = y-1; j <= y+1; j++){
        if(i < 0 || i > _field.sizeX-1 || j < 0 || j > _field.sizeY-1){
          continue;
        }
        
        tempList.add(_field.grid[i][j]);
      }
    }
    return tempList;
  }
  
}