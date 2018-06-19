
class Food extends NormalItem{

  float feedAmount;
  
  public Food(float amount){
    this.feedAmount = amount;
  }
  
  public boolean use(Body body){
    body.hunger.add(feedAmount);
    return true;
  }
  
}