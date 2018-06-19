
public enum AiAgentState{
  None, Init, Error, WaitingForPath, Walking
}

class AiAgent{

  AiAgentState state;
  
  Queue<Tile> _path;
  Tile _currentTile;
  
  float speed;
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  public AiAgent(float speed){
    this.state = AiAgentState.Init;
    this._path = new ArrayDeque();
    
    this.speed = speed;
    
    this.position = new PVector();
    this.velocity = new PVector();
    this.acceleration = new PVector();
  }
  
  public void update(){
    if(state == AiAgentState.Walking && !_path.isEmpty()){
      Tile t = _path.peek();
      PVector dir = PVector.sub(t.getPosition(), position);
      
      dir.normalize();
      dir.mult(speed);
      
      acceleration = dir;
      position.add(acceleration);
      
      if(PVector.dist(position, t.getPosition()) < 3){
        _currentTile = _path.poll();
        
        if(_path.isEmpty()){
          state = AiAgentState.WaitingForPath;
        }
      }
    }
    
    if(state == AiAgentState.Walking && _path.isEmpty()){
      state = AiAgentState.Error;
      print("Entity got in the Error state!\n");
    }
  }
  
  public void show(){
    pushStyle();
    fill(255,0,0);
    strokeWeight(0);
    stroke(0);
    ellipse(position.x, position.y, 8, 8);
    popStyle();
    
    this.drawPathLine();
  }
  
  void drawPathLine(){
    pushStyle();
    strokeWeight(5);
    stroke(0,255,0, 120);
    
    Tile[] temp = new Tile[_path.size()];
    Tile[] _drawPath = _path.toArray(temp);
    PVector s = this.position;
    for(int i = 1; i < _drawPath.length; i++){
      Tile t = _drawPath[i];
      PVector e = t.getPosition();
      line(s.x, s.y, e.x, e.y);
      s = e;
    }
    
    popStyle();
  }
  
  public void setPath(Queue<Tile> _path){
    this._path.clear();
    this._path = _path;
  }
  
  public Tile getCurrentTile(){
    return _currentTile;
  }

} 