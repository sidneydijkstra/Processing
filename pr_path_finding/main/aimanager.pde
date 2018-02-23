import java.util.Queue;
import java.util.ArrayDeque;

class AiManager{
  AiCalculator AIC;
  ArrayList<Entity> aiListeners;
  
  int range = 200;
  
  private AiManager(){
    aiListeners = new ArrayList<Entity>();
    AIC = new AiCalculator();
  }
  
  public void update(Map map){
    for(int i = 0; i < aiListeners.size(); i++){
      Entity e = aiListeners.get(i);
      
      Tile t = null;
      switch(e.state){
        case None:
          break;
        case Init:
          t = map.getRandomWalkableTile();
          //e._currentTile = t;
          //e.position = t.getPosition();
          e.setPath(AIC.getPath(t, range, map));
          e.state = EntityState.Walking;
          break;
        case Error:
          t = map.getRandomWalkableTile();
          e.setPath(AIC.getPath(t, range, map));
          e.state = EntityState.Walking;
          break;
        case WaitingForPath:
          e.setPath(AIC.getPath(e.getCurrentTile(), range, map));
          e.state = EntityState.Walking;
          break;
        case Walking:
          break;
      }
      
    }
  }
  
  public void show(){
    for (int i = 0; i < aiListeners.size(); i++){
      Entity e = aiListeners.get(i);
      
      e.update();
      e.show();
    }
  }
  
  public void addAiListener(Entity e){
    if(e == null || aiListeners.contains(e)){
      print("You are trying to add a new AiListener: it is either null or already in the list! Entity: (" + e + ")");
      return;
    }
    
    aiListeners.add(e);
  }
  
  public void removeAiListener(Entity e){
    if(e == null || !aiListeners.contains(e)){
        print("You are trying to remove a AiListener: it is either null or not in the list! Entity: (" + e + ")");
        return;
    }
    
    aiListeners.remove(e);
  }
}