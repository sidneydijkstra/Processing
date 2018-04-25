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
  
  /* copy a data to this data */
  public void copy(Matrix value){
    data = value.data;
    rows = value.rows;
    cols = value.cols;
  }
  
  /* add a data to this data */
  public void add(Matrix value){
    if(this.rows != value.rows || this.cols != value.cols){
      print("You are trying to mult two data's but they are not the same size!");
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
  
  /* transpose the data */
  public void transpose(){
    
    Matrix result = new Matrix(cols, rows);
    
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        result.data[j][i] = data[i][j];
      }
    }
    
    this.copy(result);
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
  
   /* get the dot product of the data */
  public void dotProduct(Matrix value){
    if(this.cols != value.rows || this.rows != value.cols){
      print("You are trying to mult two data's but they dont have the right size!");
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
  
  /* get the dot product of the data ( this is the static funcion ) */
  public static Matrix dotProduct(Matrix a, Matrix b){
    if(a.cols != b.rows || a.rows != b.cols){
      print("You are trying to mult two data's but they dont have the right size!");
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
  
  /* randomize the values in the data with a rounded min max */
  public void randomize(){
    Random random = new Random();
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        float value = (random.nextFloat() * 2) - 1;
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