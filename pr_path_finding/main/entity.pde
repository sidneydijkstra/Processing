import java.util.Queue;
import java.util.ArrayDeque;

public enum EntityState{
  None, Init, Error, WaitingForPath, Walking
}

class Entity{
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  EntityState state;
  
  Queue<Tile> _path;
  Tile _currentTile;
  
  int _me = 0;
  
  public Entity(int _me){
    this._me = _me;
    
    state = EntityState.Init;
    _path = new ArrayDeque();
    
    position = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
  }
  
  public void update(){
    if(state == EntityState.Walking && !_path.isEmpty()){
      Tile t = _path.peek();
      print("heading (" + _me + "): " + t.position + "\n");
      PVector dir = PVector.sub(t.position, position);
      
      dir.normalize();
      
      dir.mult(2.5f);
      
      acceleration = dir;
      
      //velocity.add(acceleration);
      //velocity.limit(5);
      position.add(acceleration);
      
      if(PVector.dist(position, t.position) < 3){
        // set color back to white
        Tile y = _path.peek();
        y.DEBUGCOLOR = color(255);
        
        _currentTile = _path.poll();
        
        if(_path.isEmpty()){
          state = EntityState.WaitingForPath;
        }
      }
    }
  }
  
  public void show(){
    pushStyle();
    fill(0,120,0);
    stroke(0);
    ellipse(position.x, position.y, 15, 15);
    popStyle();
    
    strokeWeight(3);
    this.drawPathLine();
  }
  
  public void drawPathLine(){
    Tile[] temp = new Tile[_path.size()];
    Tile[] _drawPath = _path.toArray(temp);
    PVector s = this.position;
    for(int i = 0; i < _drawPath.length; i++){
      Tile t = _drawPath[i];
      PVector e = t.position;
      stroke(random(255),random(255),random(255));
      line(s.x, s.y, e.x, e.y);
      s = e;
    }
  }
  
  public void setPath(Queue<Tile> _path){
    this._path.clear();
    this._path = _path;
  }
  
  public Tile getCurrentTile(){
    return _currentTile;
  }
}