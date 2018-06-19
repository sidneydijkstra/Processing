
class Property{

  private float _min;
  private float _max;
  private float _current;
  
  public Property(float min, float max, float current){
    this._min = min;
    this._max = max;
    this._current = current;
  }
  public Property(float min, float max){
    this._min = min;
    this._max = max;
    this._current = max;
  }
  
  public float value(){
    return _current;
  }
  
  public void add(float value){
    _current += value;
    this._limit();
    
    method("sub");
  }
  
  public void sub(float value){
    _current -= value;
    this._limit();
  }
  
  public void forceMin(){
    _current = _min;
  }
  public void forceMax(){
    _current = _max;
  }
  
  public float min(){
    return _min;
  }
  public float max(){
    return _max;
  }
  
  public boolean isMin(){
    return _current == _min;
  }
  public boolean isMax(){
    return _current == _max;
  }
  public boolean notMinNotMax(){
    return !isMin() && !isMax();
  }
  
  public String string(){
    return "" + _current;
  }
  public void cout(){
    print("Value: [" + _current + "] min: [" + _min + "] max: [" + _max + "]");
  }
  
  private void _limit(){
    _current = _current < _min ? _min : _current > _max ? _max : _current;
  }
  
}