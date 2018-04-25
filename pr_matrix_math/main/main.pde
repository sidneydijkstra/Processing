
Matrix a;
Matrix b;

Matrix c;

void setup(){
  noLoop();
  
  
  a = new Matrix(2,3);
  b = new Matrix(3,2);
  
  a.randomize();
  b.randomize();
  
  //a.dotProduct(b);
  //a.cout();
  
  c = Matrix.dotProduct(a,b);
  c.cout();
  
  /*
  a.randomize(0,4);
  b.randomize(0,4);
  
  a.cout();
  b.cout();
  
  a = a.dotProduct(b);
  a.cout();
  */
}