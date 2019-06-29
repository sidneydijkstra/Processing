class AiNode{
  
  boolean visited;
  
  int gridX;
  int gridY;
  
  int precent;
  
  public AiNode(int _gridX, int _gridY){
    gridX = _gridX;
    gridY = _gridY;
    
    reset();
  }
  
  void reset(){
    visited = false;
    precent = 0;
  }
  
}