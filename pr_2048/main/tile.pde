class Tile{
  
  int number;
  
  public Tile(){
    this.number = 0;
  }
  
  public void setNumber(int num){
    this.number = num;
  }
  
  public Boolean canCombine(Tile t){
    if(this.number == t.number){
      return true;
    }
    return false;
  }
  
  public void combine(Tile t){
    this.setNumber(this.number + t.number);
  }
  
  public void destroy(){
    this.number = 0;
  }
  
  public int getNumber(){
    return this.number;
  }
  
  public boolean isZero(){
    return number == 0;
  }
  
}