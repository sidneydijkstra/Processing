class Tile{
  
  int number;
  
  public Tile(){
    this.number = 0;
  }
  
  public void setNumber(int num){
    this.number = num;
  }
  
  public int getNumber(){
    return this.number;
  }
  
  public boolean isZero(){
    return number == 0;
  }
  
}