
public enum EntityState{
  Idle, Seek, Use, Sleep, Dead, Socialize
}

class Entity extends AiAgent{
  
  Body body;
  
  public Entity(){
    super(5.0f);
    
    body = new Body();
  }
  
  public void update(){
    super.update();
  }
  
  public void show(){
    super.show();
  }
}