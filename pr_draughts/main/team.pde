public class Team{

  NodeType _type;
  Board _board;
  ArrayList<Piece> _pieces; 
  int _amount;
  Boolean active;
  
  public Team(NodeType _type, Board _board, int _amount){
    this._type = _type;
    this._board = _board;
    this._amount = _amount;
    
    active = false;
  }
  
  Boolean containsPiece(int _x, int _y){
    for(int i = 0; i < _pieces.size(); i++){
      Piece piece = _pieces.get(i);
      if(piece.gridX == _x && piece.gridY == _y){
        return true;
      }
    }
    return false;
  }
  
  Piece getPiece(int _x, int _y){
    for(int i = 0; i < _pieces.size(); i++){
      Piece piece = _pieces.get(i);
      if(piece.gridX == _x && piece.gridY == _y){
        return piece;
      }
    }
    return null;
  }
  
  void setupPieces(NodeType _nodeType){
    _pieces = new ArrayList<Piece>();
    Node[][] _nodes = _board._nodes; // cash nodes
    
    int x;
    int y;
    
    // 5 is the offset (so peice is not as big as a node)
    int pieceWidth = width / _board.sizeX;
    int pieceHeight = height / _board.sizeY;
    
    if(_type == NodeType.BLACK){
      // spawn piece's in top side
      x = 0;
      y = 0;
      
      while(_pieces.size() != _amount){
        if(_nodes[y][x].type == _nodeType){
          _pieces.add(new Piece(_type, x, y, pieceWidth, pieceHeight));
        }
        
        if(x + 1 >= _board.sizeX){
          x = 0;
          y++;
        }else{
          x++;
        }
      }
      
    }else{
      // spawn piece's in bottom side
      x = 0;
      y = _board.sizeY - 1;
      
      while(_pieces.size() != _amount){
        if(_nodes[y][x].type == _nodeType){
          _pieces.add(new Piece(_type, x, y, pieceWidth, pieceHeight));
        }
        
        if(x + 1 >= _board.sizeX){
          x = 0;
          y--;
        }else{
          x++;
        }
      }
    }
  }
  
  void show(){
    for(int i = 0; i < _pieces.size(); i++){
      Piece p = _pieces.get(i);
      p.show();
    }
  }
  
  void OnClick(){
    if(!active)
      return;
      
    for(int i = 0; i < _pieces.size(); i++){
      Piece p = _pieces.get(i);
      p.OnClick(_board);
    }
  }
  
}