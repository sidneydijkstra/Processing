
Matrix a;
Matrix b;
Matrix c;

void setup(){
  noLoop();
  
  // from array test
  print("----===== TEST1 [fromArray] =====----\n");
  print("[int] :\n");
  printArray(new int[]{0, 1, 2});
  a = Matrix.fromArray(new int[]{0, 1, 2});
  a.cout();
  print("[float] :\n");
  printArray(new float[]{1.2, 3.5, 7.8});
  a = Matrix.fromArray(new float[]{1.2, 3.5, 7.8});
  a.cout();
  print("[bool] :\n");
  printArray(new Boolean[]{true, false, true});
  a = Matrix.fromArray(new Boolean[]{true, false, true});
  a.cout();
  
  // to array test
  print("----===== TEST2 [toArray] =====----\n");
  print("[int] :\n");
  a = Matrix.fromArray(new float[]{1.2, 3.5, 7.8});
  a.cout();
  printArray(Matrix.toFloatArray(a));
  print("[float] :\n");
  a = Matrix.fromArray(new int[]{1, 2, 3});
  a.cout();
  printArray(Matrix.toFloatArray(a));
  
  // add test
  print("----===== TEST3 [add] =====----\n");
  a = new Matrix(2,2);
  b = new Matrix(2,2);
  c = new Matrix(2,2);
  a.randomize();
  b.randomize();
  
  print("A:\n");
  a.cout();
  print("B:\n");
  b.cout();
  
  print("[static] C:\n");
  c = Matrix.add(a,b);
  c.cout();
  
  print("[normal] C:\n");
  a.add(b);
  a.cout();
  
  // sub test
  print("----===== TEST4 [sub] =====----\n");
  a = new Matrix(2,2);
  b = new Matrix(2,2);
  c = new Matrix(2,2);
  a.randomize();
  b.randomize();
  
  print("A:\n");
  a.cout();
  print("B:\n");
  b.cout();
  
  print("[static] C:\n");
  c = Matrix.sub(a,b);
  c.cout();
  
  print("[normal] C:\n");
  a.sub(b);
  a.cout();
  
  // mult test
  print("----===== TEST5 [mult] =====----\n");
  a = new Matrix(2,2);
  b = new Matrix(2,2);
  c = new Matrix(2,2);
  a.randomize();
  b.randomize();
  
  print("A:\n");
  a.cout();
  print("B:\n");
  b.cout();
  
  print("[static] C:\n");
  c = Matrix.mult(a,b);
  c.cout();
  
  print("[normal] C:\n");
  a.mult(b);
  a.cout();
  
  // transepose test
  print("----===== TEST6 [transpose] =====----\n");
  a = new Matrix(3,2);
  c = new Matrix(2,3);
  a.randomize();
  
  print("A:\n");
  a.cout();
  
  print("[static] C:\n");
  c = Matrix.transpose(a);
  c.cout();
  
  print("[normal] C:\n");
  a.transpose();
  a.cout();
  
  
  // dot product test
  print("----===== TEST7 [dot] =====----\n");
  a = new Matrix(2,3);
  b = new Matrix(3,2);
  c = new Matrix(2,2);
  a.randomize();
  b.randomize();
  
  print("A:\n");
  a.cout();
  print("B:\n");
  b.cout();
  
  print("[static] C:\n");
  c = Matrix.dot(a,b);
  c.cout();
  
  print("[normal] C:\n");
  a.dot(b);
  a.cout();
}