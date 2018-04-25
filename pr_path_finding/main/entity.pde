import java.util.Queue;
import java.util.ArrayDeque;

public enum EntityState{
  None, Init, Error, WaitingForPath, Walking
}

class Entity{
  EntityState state;
  int _id = 0;
  
  Queue<Tile> _path;
  Tile _currentTile;
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float foodSearchRange;
  Boolean hasFood;
  int foodAmount;
  Tile home;
  
  public Entity(int _id){
    this._id = _id;
    
    state = EntityState.Init;
    _path = new ArrayDeque();
    
    position = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    
    foodSearchRange = 200.0f;
    hasFood = false;
    foodAmount = 0;
  }
  
  public void update(){
    if(state == EntityState.Walking && !_path.isEmpty()){
      Tile t = _path.peek();
      PVector dir = PVector.sub(t.getPosition(), position);
      
      dir.normalize();
      dir.mult(5.0f);
      
      acceleration = dir;
      position.add(acceleration);
      
      if(PVector.dist(position, t.getPosition()) < 3){
        _currentTile = _path.poll();
        
        if(_path.isEmpty()){
          state = EntityState.WaitingForPath;
        }
      }
    }
    
    if(state == EntityState.Walking && _path.isEmpty()){
      state = EntityState.Error;
      print("Entity (" + _id + ") got in the Error state!\n");
    }
  }
  
  public void show(){
    pushStyle();
    fill(255,0,0);
    strokeWeight(0);
    stroke(0);
    ellipse(position.x, position.y, 8, 8);
    popStyle();
    
    pushStyle();
    strokeWeight(5);
    stroke(0,255,0, 120);
    this.drawPathLine();
    popStyle();
  }
  
  public void drawPathLine(){
    Tile[] temp = new Tile[_path.size()];
    Tile[] _drawPath = _path.toArray(temp);
    PVector s = this.position;
    for(int i = 1; i < _drawPath.length; i++){
      Tile t = _drawPath[i];
      PVector e = t.getPosition();
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
  
  public void setHome(Tile t){
    if(t.containsHome){
      print("Can't set home of entity: " + _id);
      return;
    }
    t.containsHome = true;
    home = t;
  }
  
  public Boolean isHome(){
    return home == _currentTile;
  }
}