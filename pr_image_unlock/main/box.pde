class Box{
  
  Boolean _open;
  
  // box display vars
  int _x;
  int _y;
  int _width;
  int _height;
  color _color;
  
  // box spread vars
  int[] colorArray;
  Box[] boxes;
  
  public Box(int x, int y, int w, int h, int[] array){
    
    this._x = x;
    this._y = y;
    
    this._width = w;
    this._height = h;
    
    this.colorArray = array;
    
    this._open = false;
    
    this.calculateColor(array);
  }
  
  public void show(){
    if(_open){
      for(int i = 0; i < boxes.length; i++){
        boxes[i].show();
      }
      return;
    }
    
    noStroke();
    fill(_color);
    rect(_x, _y, _width, _height);
  }
  
  public void click(int x, int y){
    if(_open){
      for(int i = 0; i < boxes.length; i++){
        boxes[i].click(x,y);
      }
      return;
    }
    
    if(inBox(x, y)){ //<>//
      this.pop();
    }
  }
  
  private void pop(){ //<>//
    boxes = new Box[4];
    
    int[][] split = this.splitColorArray(colorArray);
    
    int w = _width/2;
    int h = _height/2;
    
    boxes[0] = new Box(_x, _y, w, h, split[0]);
    boxes[1] = new Box(_x + w, _y, w, h, split[1]);
    boxes[2] = new Box(_x, _y + h, w, h, split[2]);
    boxes[3] = new Box(_x + w, _y + h, w, h, split[3]);
    
    this._open = true;
  }
  
  private Boolean inBox(int x, int y){
    if(x > _x && x < _x+_width && y > _y && y < _y+_height){
        return true;
    }
    return false;
  }
  
  private void calculateColor(int[] array){
    int r = 0;
    int g = 0;
    int b = 0;
    
    for(int i = 0; i < array.length; i++){
      color c = array[i];
      r += red(c);
      g += green(c);
      b += blue(c);
    }
    
    int l = array.length;
    _color = color(r/l, g/l, b/l);
  }
  
  private int[][] splitColorArray(int[] array){
    
    int wsize = _width/2;
    int hsize = _height/2;
    
    ArrayList a = new ArrayList();
    ArrayList b = new ArrayList();
    ArrayList c = new ArrayList();
    ArrayList d = new ArrayList();
    
    for(int i = 0; i < array.length; i++){
      int x = i % _width;
      int y = (i-x) / _height;
      
      if(x < wsize && y < hsize){
        a.add(array[i]);
      }else if(x >= wsize && y < hsize){
        b.add(array[i]);
      }else if(x < wsize && y >= hsize){
        c.add(array[i]);
      }else if(x >= wsize && y >= hsize){
        d.add(array[i]);
      }
    }
    
    int[][] list = new int[4][];
    list[0] = this.arrayListToIntList(a);
    list[1] = this.arrayListToIntList(b);
    list[2] = this.arrayListToIntList(c);
    list[3] = this.arrayListToIntList(d);
   
    return list;
  }
  
  private int[] arrayListToIntList(ArrayList list){
    int[] result = new int[list.size()];
    for(int i = 0; i < list.size(); i++)
      result[i] = (int)list.get(i);
    return result;
  }
  
}