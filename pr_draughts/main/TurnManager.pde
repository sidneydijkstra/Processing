public static class TurnManager{
  static TurnManager _instance;
  
  Team _black;
  Team _white;
  
  private TurnManager(){
  }
  
  static TurnManager getInstance(){
    if(_instance == null)
      _instance = new TurnManager();
    return _instance;
  }
  
  void init(Team _black, Team _white){
    this._black = _black;
    this._white = _white;
    
    _black.active = true;
  }
  
  void nextTurn(){
    _black.active = !_black.active;
    _white.active = !_white.active;
  }
  
}