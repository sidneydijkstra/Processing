class Field{
  
  Dot[] _dots;
  
  public Field(){
    _dots = new Dot[10];
    
    for(int i = 0; i < _dots.length; i++){
      _dots[i] = new Dot();
    }
  }
  
  void update(){
    for(int i = 0; i < _dots.length; i++){
      _dots[i].update(_dots);
    }
  }
  
  void show(){
    for(int i = 0; i < _dots.length; i++){
      _dots[i].show();
    }
  }
  
}