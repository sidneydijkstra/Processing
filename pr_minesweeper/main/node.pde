
class Node extends AiNode{
  
  PVector position;
  PVector size;
  
  boolean isMine;
  boolean isOpen;
  boolean isFlag;
  
  int surroundedMines;
  
  public Node(PVector _position, PVector _size, PVector _gridPosition){
    super((int)_gridPosition.x, (int)_gridPosition.y);
    
    position = _position;
    size = _size;
    
    isMine = false;
    isOpen = false;
    isFlag = false;
  }
  
  void show(){
    if(isOpen){
      fill(150);
      rect(position.x, position.y, size.x, size.y);
      
      // draw count and mine text
      showText();
    }else if(isFlag){
      fill(210);
      rect(position.x, position.y, size.x, size.y);
      
      fill(200, 0, 0);
      rect(position.x + (size.x/4), position.y + (size.y/4), size.x/2, size.y/2);
    }else{
      fill(210);
      rect(position.x, position.y, size.x, size.y);
    }
  }
  
  void peek(){
    if(isOpen){
      fill(150);
      rect(position.x, position.y, size.x, size.y);
      
      // draw count and mine text
      showText();
    }else if(isFlag){
      fill(210);
      rect(position.x, position.y, size.x, size.y);
      
      fill(200, 0, 0);
      rect(position.x + (size.x/4), position.y + (size.y/4), size.x/2, size.y/2);
    }else{
      fill(210);
      rect(position.x, position.y, size.x, size.y);
      
      // draw count and mine text
      showText();
    }
  }
  
  void debug(){
        if(!isOpen){
        fill(255, 0, 0);
        textSize(9);
        textAlign(CENTER, CENTER);
        float tempPrecent = 12.5 * (float)precent;
        text(precent + "", position.x + (size.x/2), position.y + (size.y/2));
      }
  }
  
  void showText(){
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(12);
      if(!isMine && surroundedMines > 0){
        text("" + surroundedMines, position.x + (size.x/2), position.y + (size.y/2));
      }else if(isMine){
        fill(200, 0, 0);
        text("M", position.x + (size.x/2), position.y + (size.y/2));
      }
  }
  
  void open(){
    if(isMine){
      return;
    }
    
    isOpen = true;
  }
  
  void flag(){
    if(!isOpen){
      isFlag = !isFlag;
    }
  }
  
}