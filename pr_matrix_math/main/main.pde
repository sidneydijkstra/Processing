
Matrix a;
Matrix b;

void setup(){
  noLoop();
  
  
  a = new Matrix(2,3);
  b = new Matrix(3,2);
  
  a.randomize(0,4);
  a.cout();
  a.transpose();
  a.cout();
  
  /*
  a.randomize(0,4);
  b.randomize(0,4);
  
  a.cout();
  b.cout();
  
  a = a.dotProduct(b);
  a.cout();
  */
}