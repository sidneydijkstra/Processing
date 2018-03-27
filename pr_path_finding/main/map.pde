class Map{
  
  Tile[] _tiles;
  
  ArrayList<Tile> _walkableTiles;
  ArrayList<Tile> _unwalkableTiles;
  
  int _mapWidth;
  int _mapHeight;
  
  int _tileWidth;
  int _tileHeight;

  public Map(int _width, int _height){
    _walkableTiles = new ArrayList<Tile>();
    _unwalkableTiles = new ArrayList<Tile>();
    
    // set map size
    this._mapWidth = _width;
    this._mapHeight = _height;
    
    // set tile size
    this._tileWidth = width / _width;
    this._tileHeight = height / _height;
    
    this.generateMap();
  }
  
  private void generateMap(){
    // init tiles
    _tiles = new Tile[_mapWidth*_mapHeight];
    
    for(int y = 0; y < _mapHeight; y++){
      for(int x = 0; x < _mapWidth; x++){
        int index = (y * _mapWidth) + x;
        
        int posY = y * _tileHeight;
        int posX = x * _tileWidth;
        
        _tiles[index] = new Tile(x, y, posX, posY, _tileWidth, _tileHeight);
        
        if(random(100) <= 10){//&& _mapWidth*_mapHeight > index){
          _tiles[index].isWalkable = false;
          _unwalkableTiles.add(_tiles[index]);
        }else{
          if(random(100) <= 10){
            //_tiles[index].containsHome = true;
          }
          _walkableTiles.add(_tiles[index]);
        }
      }
    }
  }
  
  public void update(){
    // create new things for the ai to do / survive
  }
  
  public void show(){
    for(int i = 0; i < _tiles.length; i++){
      _tiles[i].update();
      _tiles[i].show();
    }
  }
  
  public int getMapSizeX(){
    return _mapWidth;
  }
  
  public int getMapSizeY(){
    return _mapHeight;
  }
  
  public Tile[] getAllTiles(){
    return _tiles;
  }
  
  public Tile getRandomTile(){
    int rand = floor(random(0, _tiles.length-1));
    return _tiles[rand];
  }
  
  public ArrayList<Tile> getAllWalkableTiles(){
    return _walkableTiles;
  }
  
  public ArrayList<Tile> getAllUnWalkableTiles(){
    return _unwalkableTiles;
  }
  
  public Tile getRandomWalkableTile(){
    int rand = floor(random(0, _walkableTiles.size()-1));
    return _walkableTiles.get(rand);
  }
  
  public Tile getRandomUnWalkableTile(){
    int rand = floor(random(0, _unwalkableTiles.size()-1));
    return _unwalkableTiles.get(rand);
  }
  
}