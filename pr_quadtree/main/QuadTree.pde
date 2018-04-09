class QuadTree{

  int QT_NODE_CAPACITY = 4;
  
  ArrayList<Rectangle> childeren;
  Rectangle boundary;
  
  Boolean divided;
  
  QuadTree northWest;
  QuadTree northEast;
  QuadTree southWest;
  QuadTree southEast;
  
  public QuadTree(Rectangle _boundary){
    this.boundary = _boundary;
    
    childeren = new ArrayList<Rectangle>();
    
    northWest = null;
    northEast = null;
    southWest = null;
    southEast = null;
    divided = false;
  }
  
  public void show(){
    if(!divided){ //<>//
      //noFill();
      stroke(255);
      strokeWeight(2);
      
      rectMode(CENTER);
      
      rect(boundary.center.x, boundary.center.y, boundary.size, boundary.size);
    }else{
      northWest.show();
      northEast.show();
      southWest.show();
      southEast.show();
    }
  }
  
  public Boolean insert(Rectangle child){
    // child is not inside this QT
    if(!boundary.contains(child.center)){
      return false;
    }
    
    // check if there is room inside this
    if(!divided && childeren.size() < QT_NODE_CAPACITY){
      childeren.add(child);
      return true;
    }
    
    // devide QT if not divided yet
    if(!divided){
      this.subdivide();
    }
    
    // add child to correct QT
    if(northWest.insert(child))
      return true;
    if(northEast.insert(child))
      return true;
    if(southWest.insert(child))
      return true;
    if(southEast.insert(child))
      return true;
    
    return false;
  }
  
  private void subdivide(){
    divided  = true;
    
    // get vars to calculate new Rectangle's for QT's
    float x = boundary.center.x;
    float y = boundary.center.y;
    float hX = x/2;
    float hY = y/2;
    
    // create new QT's
    northWest = new QuadTree(new Rectangle(new PVector(x-hX, y-hY), boundary.size/2));
    northEast = new QuadTree(new Rectangle(new PVector(x+hX, y-hY), boundary.size/2));
    southWest = new QuadTree(new Rectangle(new PVector(x-hX, y+hY), boundary.size/2));
    southEast = new QuadTree(new Rectangle(new PVector(x+hX, y+hY), boundary.size/2));
    
    // add childeren to right new QT
    
    // clear array
    //childeren.clear();
  }
  
}