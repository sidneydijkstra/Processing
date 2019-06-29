public class Board{

  int sizeX;
  int sizeY;
  
  Node[][] _nodes;
  
  Team _black;
  Team _white;
  
  public Board(int _sizeX, int _sizeY){
    this.sizeX = _sizeX;
    this.sizeY = _sizeY; 
    
    
    this.createGrid();
  }
  
  void addTeams(Team _black, Team _white){
    this._black = _black;
    this._white = _white;
  }
  
  Boolean inGrid(int _x, int _y){
    return _x >= 0 && _x < sizeX && _y >= 0 && _y < sizeY;
  }
  
  Boolean isEmpty(int _x, int _y){
    return inGrid(_x, _y) && !_black.containsPiece(_x,_y) && !_white.containsPiece(_x,_y);
  }
  
  Node getNode(int _x, int _y){
    if(inGrid(_x, _y)){
      return _nodes[_x][_y];
    }
    return null;
  }
  
  void activateNode(Piece _piece, int _x, int _y, int _nextX, int _nextY, Boolean _canOnlySlayBackwards){
    if(inGrid(_x, _y)){
      if(_piece.type == NodeType.BLACK){
        if(_black.containsPiece(_x,_y))
          return;
        
        if(_white.containsPiece(_x,_y) && isEmpty(_nextX, _nextY)){
          Node n = getNode(_nextX, _nextY);
          n.highlight = true;
          n.movePiece = _piece;
          n.destroyPiece = _white.getPiece(_x,_y);
          
        }else if(!_canOnlySlayBackwards && !_white.containsPiece(_x,_y)){
          Node n = getNode(_x, _y);
          n.highlight = true;
          n.movePiece = _piece;
        }
        
      }else{
        if(_white.containsPiece(_x,_y))
          return;
        
        if(_black.containsPiece(_x,_y) && isEmpty(_nextX, _nextY)){
          Node n = getNode(_nextX, _nextY);
          n.highlight = true;
          n.movePiece = _piece;
          n.destroyPiece = _black.getPiece(_x,_y);
          
        }else if(!_canOnlySlayBackwards && !_black.containsPiece(_x,_y)){
          Node n = getNode(_x, _y);
          n.highlight = true;
          n.movePiece = _piece;
        }
      }
    }
  }
  
  void activateKingNode(Piece _piece, int _x, int _y){
    Team badTeam = _piece.type == NodeType.BLACK ? _black : _white;
    Team goodTeam = _piece.type == NodeType.BLACK ? _white : _black;
    Boolean slayedPiece = false;
    Piece badPeace = null;
    
    // bottom-left
    for(int i = 1; i < 10; i++){
      if(inGrid(_x, _y)){
        
        if(badTeam.containsPiece(_x + i, _y + i)){
          
          if(inGrid(_x + i + 1, _y + i + 1) && isEmpty(_x + i + 1, _y + i + 1) && !slayedPiece){ // on found bad peace
            slayedPiece = true;
            badPeace = badTeam.getPiece(_x + i, _y + i);
          }else if(inGrid(_x + i + 1, _y + i + 1) && isEmpty(_x + i + 1, _y + i + 1) && slayedPiece){ // on found bad peace number two
            Node n = getNode(_x + i + 1, _y + i + 1);
            n.highlight = true;
            n.movePiece = _piece;
            n.destroyPiece = _black.getPiece(_x,_y);
          }else{ // on not in grid or not 
            break; // exit loop
          }
          
        }
        
        if(isEmpty(_x + i, _y + i)){
          
        }
          
          
        
        
      }
    }
  }
  
  void resetNode(){
    for(int i = 0; i < sizeY; i++){
      for(int j = 0; j < sizeX; j++){
        _nodes[i][j].highlight = false;
        _nodes[i][j].movePiece = null;
        _nodes[i][j].destroyPiece = null;
      }
    }
  }
  
  void createGrid(){
    _nodes = new Node[sizeY][];
    
    Node[] _tempNodes;
    NodeType _tempType = NodeType.WHITE;
    
    int nodeHeight = height / sizeY;
    int nodeWidth = width / sizeX;
    
    for(int i = 0; i < sizeY; i++){
      _tempNodes = new Node[sizeX];
      for(int j = 0; j < sizeX; j++){
        _tempNodes[j] = new Node(_tempType, i, j, nodeWidth, nodeHeight);
        _tempType = _tempType == NodeType.WHITE ? NodeType.BLACK : NodeType.WHITE;
      }
      _nodes[i] = _tempNodes;
    }
  }
  
  void show(){
    for(int i = 0; i < sizeX; i++){
      for(int j = 0; j < sizeY; j++){
        _nodes[i][j].show();
      }
    }
  }
  
  void OnClick(){
    for(int i = 0; i < sizeX; i++){
      for(int j = 0; j < sizeY; j++){
        _nodes[i][j].OnClick();
      }
    }
  }
  
}