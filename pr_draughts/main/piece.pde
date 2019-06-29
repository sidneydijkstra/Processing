public class Piece{
  
  Boolean destroy;
  Boolean isKing;
  
  NodeType type;
  int _sizeWidth;
  int _sizeHeight;
  
  ArrayList<Move> possibleMoves;
  
  int gridX;
  int gridY;
  
  public Piece(NodeType _type, int _gridX, int _gridY, int _sizeWidth, int _sizeHeight){
    this.type = _type;
    
    this.gridX = _gridX;
    this.gridY = _gridY;
    
    this._sizeWidth = _sizeWidth;
    this._sizeHeight = _sizeHeight;
    
    destroy = false;
    isKing = false;
  }
  
  void showMoves(Board _board){
    _board.resetNode();
    
    if(isKing){
      for(int i = 1; i < 12; i++){
        _board.activateNode(this, gridX + i, gridY + i, gridX + (i+1), gridY + (i+1), false);
        _board.activateNode(this, gridX - i, gridY + i, gridX - (i+1), gridY + (i+1), false);
        
        _board.activateNode(this, gridX + i, gridY - i, gridX + (i+1), gridY - (i+1), false);
        _board.activateNode(this, gridX - i, gridY - i, gridX - (i+1), gridY - (i+1), false);
      }
    }else if(type == NodeType.BLACK){
      _board.activateNode(this, gridX + 1, gridY + 1, gridX + 2, gridY + 2, false);
      _board.activateNode(this, gridX - 1, gridY + 1, gridX - 2, gridY + 2, false);
      
      // backwards
      _board.activateNode(this, gridX + 1, gridY - 1, gridX + 2, gridY - 2, true);
      _board.activateNode(this, gridX - 1, gridY - 1, gridX - 2, gridY - 2, true);
    }else{
      _board.activateNode(this, gridX + 1, gridY - 1, gridX + 2, gridY - 2, false);
      _board.activateNode(this, gridX - 1, gridY - 1, gridX - 2, gridY - 2, false);
      
      // backwards
      _board.activateNode(this, gridX + 1, gridY + 1, gridX + 2, gridY + 2, true);
      _board.activateNode(this, gridX - 1, gridY + 1, gridX - 2, gridY + 2, true);
    }
  }
  
  void Move(Node _node){
    print("Dank");
    gridX = _node.gridX;
    gridY = _node.gridY;
    
    if(_node.gridY == _board.sizeY && type == NodeType.BLACK || _node.gridY == 0 && type == NodeType.WHITE){
      this.isKing = true;
    }
    _board.resetNode();
  }
  
  void show(){
    if(destroy)
      return;
    
    if(type == NodeType.BLACK){
      fill(0); // color black
    }else{
      fill(255); // color white
    }
    
    if(isKing){
      stroke(255, 0, 0);
    }
    
    int x = gridX * _sizeWidth + _sizeWidth / 2;
    int y = gridY * _sizeHeight + _sizeHeight / 2;
    
    ellipse(x, y, _sizeWidth - 5, _sizeHeight - 5);
  }
  
  void OnClick(Board _board){
    if(destroy)
      return;
    
    int x = gridX * _sizeWidth + _sizeWidth / 2;
    int y = gridY * _sizeHeight + _sizeHeight / 2;
    if(PVector.dist(new PVector(mouseX, mouseY),new PVector(x, y)) < _sizeWidth - 5){
      showMoves(_board);
    }
  }
}