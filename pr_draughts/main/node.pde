
public enum NodeType{
  WHITE,
  BLACK
}

public class Node{
  
  Boolean highlight;
  Piece movePiece;
  Piece destroyPiece;
  
  NodeType type;
  int _sizeWidth;
  int _sizeHeight;
  
  int gridX;
  int gridY;
  
  public Node(NodeType _type, int _gridX, int _gridY, int _sizeWidth, int _sizeHeight){
    this.type = _type;
    
    this.gridX = _gridX;
    this.gridY = _gridY;
    
    this._sizeWidth = _sizeWidth;
    this._sizeHeight = _sizeHeight;
    
    highlight = false;
  }
  
  void show(){
    if(type == NodeType.BLACK){
      fill(100); // color black
    }else{
      fill(155); // color white
    }
    
    if(highlight){
      fill(0, 200, 0);
    }
    
    stroke(0);
    
    int x = gridX * _sizeWidth;
    int y = gridY * _sizeHeight;
    
    rect(x, y, _sizeWidth, _sizeHeight);
  }
  
  void OnClick(){
    if(movePiece == null)
      return;
      
    int x = gridX * _sizeWidth;
    int y = gridY * _sizeHeight;
    
    if(mouseX >= x && mouseX <= (x + _sizeWidth) && mouseY >= y && mouseY <= (y + _sizeHeight)){ //<>// //<>// //<>// //<>// //<>//
      if(destroyPiece == null)
        TurnManager.getInstance().nextTurn();
      else
        destroyPiece.destroy = true;
        
      movePiece.Move(this);
    }
  }
  
}