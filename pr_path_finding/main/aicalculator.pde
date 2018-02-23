import java.util.Queue;
import java.util.ArrayDeque;

class AiCalculator{

  public AiCalculator(){
  }
  
  public Queue<Tile> getPath(Tile start, Tile end, Map map){ // <-- get a path from a set pos to a set pos
    ArrayList path = this.calculateSetPath(start, end, map);
    return this.flipArrayListToQueue(path);
  }
  
  public Queue<Tile> getPath(Tile start, Map map){ // <-- get a path from a set pos to a random pos
    Tile end = map.getRandomWalkableTile();
    ArrayList path = this.calculateSetPath(start, end, map);
    return this.flipArrayListToQueue(path);
  }
  
  private ArrayList<Tile> calculateSetPath(Tile start, Tile end, Map map){
    //print("yeah im starting to calculate\n");
    
    ArrayList<Tile> open = new ArrayList<Tile>();
    ArrayList<Tile> closed = new ArrayList<Tile>();
    
    open.add(start);
    while(open.size() > 0){
      Tile current = null;
      
      // get lowest fCost tile
      float fCost = -1;
      for(Tile t : open){
        if(t.fCost <= fCost || fCost == -1){
          fCost = t.fCost;
          current = t;
        }
      }
      
      if(current == null){
        continue; // <-- this should never be the case
      }
      
      //current.DEBUGCOLOR = color(0,0,255);
      
      // remove current from open and add it to closed
      open.remove(current);
      closed.add(current);
      
      if(current == end){
        break; // <-- we found the end
      }
      
      // get all the neigbour tiles of current and loop throug them
      ArrayList<Tile> neighbours = this.getNeighbours(current, map);
      for(Tile n : neighbours){
        
        // check if in closed or not walkable
        if(closed.contains(n) || !n.isWalkable){
          continue;
        }
        
        // calculate if these tiles are good to move to
        int costToNeighbour = current.gCost + this.getDistance(current, n);
        if(current.gCost < costToNeighbour || !open.contains(n)){
          n.gCost = costToNeighbour;
          n.hCost = this.getDistance(n, end);
          n.fCost = costToNeighbour + this.getDistance(n, end);
          n.parent = current;

          if (!open.contains(n)) {
              open.add(n);
          }
        }
      }
    }
    
    ArrayList<Tile> path = new ArrayList<Tile>();
    Tile current = end;
    
    while(current != start){
      path.add(current);
      current = current.parent;
    }
    
    path.add(current);
    
    for(Tile t : path){
      t.DEBUGCOLOR = color(0,255,0);
    }
    
    return path;
    
    //reverse(path);
    
    
  }
  
  private ArrayList<Tile> getNeighbours(Tile t, Map map){ // <-- remove all the if statements and use two for loops
    ArrayList<Tile> neighbours = new ArrayList<Tile>();
    
    Tile[] grid = map.getAllTiles();
    
    int x = t.gridX();
    int y = t.gridY();
    
    int gridMaxX = map.getMapSizeX();
    int gridMaxY = map.getMapSizeY();
    
    //print("x:" + x + " y:" + y + " index:" + vectorToIndex(x, y, gridMaxX) +"\n");
    
    if (x - 1 > -1) neighbours.add(grid[vectorToIndex(x - 1, y, gridMaxX)]);
    if (y - 1 > -1) neighbours.add(grid[vectorToIndex(x, y - 1, gridMaxX)]);
    if (x + 1 < gridMaxX) neighbours.add(grid[vectorToIndex(x + 1, y, gridMaxX)]);
    if (y + 1 < gridMaxY) neighbours.add(grid[vectorToIndex(x, y + 1, gridMaxX)]);

    if (x - 1 > -1 && y - 1 > -1) neighbours.add(grid[vectorToIndex(x - 1, y - 1, gridMaxX)]);
    if (x - 1 > -1 && y + 1 < gridMaxY) neighbours.add(grid[vectorToIndex(x - 1, y + 1, gridMaxX)]);
    if (x + 1 < gridMaxX && y + 1 < gridMaxY) neighbours.add(grid[vectorToIndex(x + 1, y + 1, gridMaxX)]);
    if (x + 1 < gridMaxX && y - 1 > -1) neighbours.add(grid[vectorToIndex(x + 1, y - 1, gridMaxX)]);
    
    return neighbours;
  }
  
  private int getDistance(Tile from, Tile to){
    int x = from.gridX() - to.gridX();
    int y = from.gridY() - to.gridY();
  
    if (x < 0)
        x *= -1;
  
    if (y < 0)
        y *= -1;
  
    return 14 * y + 10 * (x - y);
  }
  
  private int vectorToIndex(int x, int y, int arrayWidth){
    return (y * arrayWidth) + x;
  }
  
  private ArrayList<Tile> flipArrayList(ArrayList<Tile> list){
    ArrayList<Tile> newlist = new ArrayList<Tile>();
    for(int i = list.size()-1; i >= 0; i--){
      newlist.add(list.get(i));
    }
    return newlist;
  }
  
  private Queue<Tile> flipArrayListToQueue(ArrayList<Tile> list){
    Queue<Tile> newlist = new ArrayDeque<Tile>();
    for(int i = list.size()-1; i >= 0; i--){
      newlist.add(list.get(i));
    }
    return newlist;
  }
  
}