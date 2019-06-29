
Board _board;
Team _black;
Team _white;

void setup(){
  size(400, 400);
  
  _board = new Board(9, 9);
  
  _black = new Team(NodeType.BLACK, _board, 13);
  _black.setupPieces(NodeType.BLACK);
  
  _white = new Team(NodeType.WHITE, _board, 13);
  _white.setupPieces(NodeType.BLACK);
  
  _board.addTeams(_black, _white);
  
  TurnManager.getInstance().init(_black, _white);
}

void draw(){
  background(255);
  _board.show();
  
  _black.show();
  _white.show();
}

void mousePressed(){
  _black.OnClick();
  _white.OnClick();
  
  _board.OnClick();
}