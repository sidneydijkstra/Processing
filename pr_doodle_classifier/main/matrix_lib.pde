
/*
  
  save file format
  
  (header)
  0 -> rows size (2)
  1 -> cols size (2)
   
  (data)
     rows/cols
  2 -> [0,0]
  3 -> [0,1]
  4 -> [1,0]
  5 -> [1,1]

*/

import java.util.Random;

public static class Matrix{
  
  int rows;
  int cols;
  
  float[][] data;
  
  /* constuctor that takes the rows and cols */
  public Matrix(int rows, int cols){
    if(rows <= 0 || cols <= 0){ // <-- error handeling
      print("You are trying to create a new matrix with rows or cols lower than 0, you cant do this.");
      return;
    }
    
    this.rows = rows;
    this.cols = cols;
    
    data = new float[rows][cols];
    
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        data[i][j] = 0.0f;
      }
    }
  }
  
  /* constuctor that copys the name */
  public Matrix(Matrix m){
    this.copy(m);
  }
  
  // ##################################### handy matrix functions ##################################### \\
  
  /* copy a data to this data */
  public void copy(Matrix value){
    data = value.data;
    rows = value.rows;
    cols = value.cols;
  }
  
  public float max(){
    float value = 0.0f;
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        value += data[i][j];
      }
    }
    return value;
  }
  
  /* create a matrix from a array with a int array */
  public static Matrix fromArray(int[] array){
    Matrix result = new Matrix(array.length, 1);
    
    for(int i = 0; i < array.length; i++){
      result.data[i][0] = array[i];
    }
    
    return result;
  }
  
  /* create a matrix from a array with a float array */
  public static Matrix fromArray(float[] array){
    Matrix result = new Matrix(array.length, 1);
    
    for(int i = 0; i < array.length; i++){
      result.data[i][0] = array[i];
    }
    
    return result;
  }
  
  /* create a matrix from a array with a Boolean array */
  public static Matrix fromArray(Boolean[] array){
    Matrix result = new Matrix(array.length, 1);
    
    for(int i = 0; i < array.length; i++){
      result.data[i][0] = array[i] ? 1 : 0;
    }
    
    return result;
  }
  
  /* create a int array from a Matrix */
  public static int[] toIntArray(Matrix value){
    if(value.cols > 1){
      print("You are trying to create a array from a matrix that has more colums than one!");
      return new int[0];
    }
    
    int[] result = new int[value.rows];
    
    for(int i = 0; i < value.rows; i++){
      result[i] = round(value.data[i][0]);
    }
    
    return result;
  }
  
   /* create a float array from a Matrix */
  public static float[] toFloatArray(Matrix value){
    if(value.cols > 1){
      print("You are trying to create a array from a matrix that has more colums than one!");
      return new float[0];
    }
    
    float[] result = new float[value.rows];
    
    for(int i = 0; i < value.rows; i++){
      result[i] = value.data[i][0];
    }
    
    return result;
  }
  
  // ##################################### normal matrix math functions ##################################### \\
  
  /* add a data to this data */
  public void add(Matrix value){
    if(this.rows != value.rows || this.cols != value.cols){
      print("You are trying to add two matrix's but they are not the same size!");
      return;
    }
    
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        data[i][j] += value.data[i][j];
      }
    }
  }
  
  /* add a value to all the index's of the data */
  public void add(float value){
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        data[i][j] += value;
      }
    }
  }
  
  /* sub a matrix to this matrix */
  public void sub(Matrix value){
    if(this.rows != value.rows || this.cols != value.cols){
      print("You are trying to sub two matrix's but they are not the same size!");
      return;
    }
    
    for(int i = 0; i < this.rows; i++){
      for(int j = 0; j < this.cols; j++){
        data[i][j] -= value.data[i][j];
      }
    }
  }
  
  /* sub a value to this matrix */
  public void sub(float value){
    for(int i = 0; i < this.rows; i++){
      for(int j = 0; j < this.cols; j++){
        data[i][j] -= value;
      }
    }
  }
  
  /* mult a data to this data */
  public void mult(Matrix value){
    if(this.rows != value.rows || this.cols != value.cols){
      print("You are trying to mult two data's but they are not the same size!");
      return;
    }
    
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        data[i][j] *= value.data[i][j];
      }
    }
  }
  
  /* mult a value to all the index's of the data */
  public void mult(float value){
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        data[i][j] *= value;
      }
    }
  }
  
  /* get the dot product of the data */
  public void dot(Matrix value){
    if(this.cols != value.rows || this.rows != value.cols){
      print("You are trying to dotProduct two matrix's but they dont have the right size!" + this.rows + "|" + value.rows + "|" + this.cols + "|" + value.cols + "\n");
      return;
    }
    
    Matrix result = new Matrix(this.rows, value.cols);
    
    float[][] a = this.data;
    float[][] b = value.data;
    
    for(int i = 0; i < result.rows; i++){
      for(int j = 0; j < result.cols; j++){
        float sum = 0;
        
        for(int k = 0; k < this.cols; k++){
          sum += a[i][k] * b[k][j];
        }
        
        result.data[i][j] = sum;
      }
    }
    
    this.copy(result);
  }
  
  /* transpose the data */
  public void transpose(){
    
    Matrix result = new Matrix(cols, rows);
    
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        result.data[j][i] = data[i][j];
      }
    }
    
    this.copy(result);
    //return result;
  }
  
  // ##################################### static matrix math functions ##################################### \\
  
  
  /* add a data to this data */
  public static Matrix add(Matrix a, Matrix b){
    if(a.rows != b.rows || a.cols != b.cols){
      print("You are trying to add two matrix's but they are not the same size!");
      return null;
    }
    
    Matrix result = new Matrix(a.rows, a.cols);
    
    for(int i = 0; i < result.rows; i++){
      for(int j = 0; j < result.cols; j++){
        result.data[i][j] = a.data[i][j] + b.data[i][j];
      }
    }
    
    return result;
  }
  
  /* add a data to this data */
  public static Matrix sub(Matrix a, Matrix b){
    if(a.rows != b.rows || a.cols != b.cols){
      print("You are trying to sub two matrix's but they are not the same size!");
      return null;
    }
    
    Matrix result = new Matrix(a.rows, a.cols);
    
    for(int i = 0; i < result.rows; i++){
      for(int j = 0; j < result.cols; j++){
        result.data[i][j] = a.data[i][j] - b.data[i][j];
      }
    }
    
    return result;
  }
  
  /* mult a data to this data */
  public static Matrix mult(Matrix a, Matrix b){
    if(a.rows != b.rows || a.cols != b.cols){
      print("You are trying to mult two matrix's but they are not the same size!");
      return null;
    }
    
    Matrix result = new Matrix(a.rows, a.cols);
    
    for(int i = 0; i < result.rows; i++){
      for(int j = 0; j < result.cols; j++){
        result.data[i][j] = a.data[i][j] * b.data[i][j];
      }
    }
    
    return result;
  }
  
  /* transpose the data ( this is the static funcion ) */
  public static Matrix transpose(Matrix value){
    Matrix result = new Matrix(value.cols, value.rows);
    
    for(int i = 0; i < value.rows; i++){
      for(int j = 0; j < value.cols; j++){
        result.data[j][i] = value.data[i][j];
      }
    }
    
    return result;
  }
  
  /* get the dot product of the data ( this is the static funcion ) */
  public static Matrix dot(Matrix a, Matrix b){
    if(a.cols != b.rows){
      print("You are trying to dotProduct two matrix's but they dont have the right size!");
      return null;
    }
    
    Matrix result = new Matrix(a.rows, b.cols);
    
    for(int i = 0; i < result.rows; i++){
      for(int j = 0; j < result.cols; j++){
        float sum = 0;
        
        for(int k = 0; k < a.cols; k++){
          sum += a.data[i][k] * b.data[k][j];
        }
        
        result.data[i][j] = sum;
      }
    }
    
    return result;
  }
  
  // ##################################### extra matrix functions ##################################### \\
  
  /* randomize the values in the data with a rounded min max */
  public void randomize(){
    Random random = new Random();
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        float value = (random.nextFloat() * 2) - 1;
        //float value = floor((random.nextFloat() * 10));
        data[i][j] = value;
      }
    }
  }
  
  /* print the data of the data array in the console */
  public void cout(){
    for(int i = 0; i < rows; i++){
      print("[ ");
      for(int j = 0; j < cols; j++){
        print(data[i][j]);
        
        if(j != cols-1){
          print(" , ");
        }
      }
      print(" ]\n\n");
    }
  }
  
  public String tostring(){
    String formatData = str(rows) + "," + str(cols);
    
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        formatData += "," + str(data[i][j]);
      }
    }
    
    return formatData;
  }
  
  public static Matrix fromstring(String _format){
    String[] formatData = split(_format, ",");
    
    int r = int(formatData[0]);
    int c = int(formatData[1]);
    
    Matrix tempMatrix = new Matrix(r,c);
    
    int step = 2;
    for(int i = 0; i < r; i++){
      for(int j = 0; j < c; j++){
        tempMatrix.data[i][j] = float(formatData[step]);
        step++;
      }
    }
    
    return tempMatrix;
  }
  
}

/* here i explane some functions that are hard to understand from the code

transpose function:

  Input:
      
    A: [ a , b , c ]
       [ d , e , f ]
           
  Output:
  
    A: [ a , d ]
       [ b , e ]
       [ c , f ]

dotProduct function:

    Input:
   
      A: [ a , b , c ]
         [ d , e , f ]
       
      B: [ g , j ]
         [ h , k ]
         [ i , l ]
    
    Output:
   
      C: [ (a * g + b * h + c * i) , (a * j + b * k + c * l) ]
         [ (d * g + e * h + f * i) , (d * j + e * k + f * l) ]

*/