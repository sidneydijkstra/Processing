
class Body{
  Property health;
  Property hunger;
  Property speed;
  Property strength;
  Property happiness;
  
  public Body(){
    health = new Property(0, 100);
    hunger = new Property(0, 100);
    
    speed = new Property(2, 10);
    strength = new Property(2, 10);
    
    happiness = new Property(0, 100);
  }
  
  public boolean isDeath(){
    if(health.isMin()){
      return true;
    }
    return false;
  }
  
}