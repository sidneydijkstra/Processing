import java.util.Queue;
import java.util.ArrayDeque;

class AiManager{
  private AiCalculator AIC;
  private ArrayList<Entity> aiListeners;
  
  private AiManager(){
    aiListeners = new ArrayList<Entity>();
    AIC = new AiCalculator();
  }
  
  public void update(Map map){
    for(int i = 0; i < aiListeners.size(); i++){
      Entity e = aiListeners.get(i);
      
      switch(e.state){
        case None:
          break;
        case Init:
          Tile t = map.getRandomWalkableTile();
          e.position = t.position;
          e.setPath(AIC.getPath(t, map));
          e.state = EntityState.Walking;
          break;
        case Error:
          break;
        case WaitingForPath:
          e.setPath(AIC.getPath(e.getCurrentTile(), map));
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