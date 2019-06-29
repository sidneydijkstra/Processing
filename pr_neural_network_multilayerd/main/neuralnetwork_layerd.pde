public class NeuralNetworkLayerd{
  
  int inputNodesSize;
  int[] hiddenNodesSizes;
  int outputNodesSize;
  
  float learningRate;
  
  Matrix[] _bias;
  Matrix[] _weight;
  
  public NeuralNetworkLayerd(int _inputNodesSize, int[] _hiddenNodesSizes, int _outputNodesSize){
    // create all bias's ( for all hidden layers and output layer, input layer get send by user )
    int size = _hiddenNodesSizes.length + 1;
    this._bias = new Matrix[size];
    for(int i = 0; i < size-1; i++){
      this._bias[i] = new Matrix(_hiddenNodesSizes[i], 1);
    }
    this._bias[size-1] = new Matrix(_outputNodesSize, 1);
    
    // create all weights 
    this._weight = new Matrix[size];
    this._weight[0] = new Matrix(_hiddenNodesSizes[0], _inputNodesSize);
    for(int i = 1; i < size-1; i++){ // hidden to hidden
      this._weight[i] = new Matrix(_hiddenNodesSizes[i], _hiddenNodesSizes[i-1]);
    }
    this._weight[size-1] = new Matrix(_outputNodesSize, _hiddenNodesSizes[_hiddenNodesSizes.length-1]);
    
    // randomize bias and weights
    for(int i = 0; i < size; i++){
      this._bias[i].randomize();
      this._weight[i].randomize();
    }
    
    // set learning rait
    this.learningRate = 0.1f;
  }
  
  public float[] predict(float[] _input){
    int size = _bias.length;
    Matrix first = Matrix.fromArray(_input);
    Matrix last;
    for(int i = 0; i < size; i++){ // loop trough layers and calculate prediction
      last = Matrix.dot(_weight[i], first);
      last.add(_bias[i]);
      first = this.sigmoid(last);
    }
    
    return Matrix.toFloatArray(first);
  }
  
  public void train(float[] _inputArray, float[] _targetArray){
    int size = _bias.length;
    
    // get input to matrix
    Matrix input = Matrix.fromArray(_inputArray);
    
    // calculate outputs
    Matrix[] outputs = new Matrix[size];
    Matrix first = input;
    Matrix last;
    for(int i = 0; i < size; i++){
      last = Matrix.dot(_weight[i], first);
      last.add(_bias[i]);
      first = this.sigmoid(last);
      outputs[i] = first;
    }
    
    // get target to matrix
    Matrix target = Matrix.fromArray(_targetArray);
    Matrix error = Matrix.sub(target, outputs[outputs.length-1]);
    for(int i = size-1; i > 0; i--){
      // calculate gradient
      Matrix gradients = this.dsigmoid(outputs[i]);
      gradients.mult(error);
      gradients.mult(this.learningRate);
      
      // calculate deltas
      Matrix transpose = Matrix.transpose(outputs[i-1]);
      Matrix deltas = Matrix.dot(gradients, transpose);
      
      // adjust weight and bias
      this._weight[i].add(deltas);
      this._bias[i].add(gradients);
      
      // Calculate this layers error
      Matrix weight_transpose = Matrix.transpose(this._weight[i]);
      error = Matrix.dot(weight_transpose, error);
    }
  }
  
  /* sigmoid function for values between -1 and 1 */
  public Matrix sigmoid(Matrix value){
    for(int i = 0; i < value.rows; i++){
      for(int j = 0; j < value.cols; j++){
        value.data[i][j] = (float)(1 / (1 + Math.exp(-value.data[i][j])));
      }
    }
    return value;
  }
  /* dsigmoid function for values between -1 and 1 */
  public Matrix dsigmoid(Matrix value){
    Matrix result = new Matrix(value.rows, value.cols);
    for(int i = 0; i < value.rows; i++){
      for(int j = 0; j < value.cols; j++){
        result.data[i][j] = (float)(value.data[i][j] * (1 - value.data[i][j]));
      }
    }
    return result;
  }
}