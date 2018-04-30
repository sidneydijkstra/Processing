public class NeuralNetwork{
  
  int inputNodesSize;
  int hiddenNodesSize;
  int outputNodesSize;
  
  Matrix weightsIH;
  Matrix weightsHO;
  
  Matrix biasHidden;
  Matrix biasOutput;
  
  float learningRate;
  
  public NeuralNetwork(int inputNodesSize, int hiddenNodesSize, int outputNodesSize){
    this.inputNodesSize = inputNodesSize;
    this.hiddenNodesSize = hiddenNodesSize;
    this.outputNodesSize = outputNodesSize;
    
    // create the weights matrix's
    this.weightsIH = new Matrix(hiddenNodesSize, inputNodesSize);
    this.weightsHO = new Matrix(outputNodesSize, hiddenNodesSize);
    
    // randomize the matrix's ( there is a way to get good working random values TODO )
    this.weightsIH.randomize();
    this.weightsHO.randomize();
    
    // create the bias matrix's
    this.biasHidden = new Matrix(hiddenNodesSize, 1);
    this.biasOutput = new Matrix(outputNodesSize, 1);
    
    // randomize the matrix's ( there is a way to get good working random values TODO )
    this.biasHidden.randomize();
    this.biasOutput.randomize();
    
    // set learning rait
    this.learningRate = 0.1f;
  }
  
  public float[] feedForward(float[] input){
    
    // create the input matrix
    Matrix inputs = Matrix.fromArray(input);
    
    // generating hidden outputs
    Matrix hidden = Matrix.dotProduct(weightsIH, inputs);
    hidden.add(biasHidden);
    // activation function
    hidden = this.sigmoid(hidden);
    
    // generating output outputs
    Matrix output = Matrix.dotProduct(weightsHO, hidden);
    output.add(biasOutput);
    // activation function
    output = this.sigmoid(output);
    
    // return the output
    return Matrix.toFloatArray(output);
  }
  
  public void train(float[] input, float[] awnser){
    
    // normal feedforward calculations
    // create the input matrix
    Matrix inputs = Matrix.fromArray(input);
    // generating hidden outputs
    Matrix hidden = Matrix.dotProduct(weightsIH, inputs);
    hidden.add(biasHidden);
    // activation function
    hidden = this.sigmoid(hidden);
    // generating output outputs
    Matrix outputs = Matrix.dotProduct(weightsHO, hidden);
    outputs.add(biasOutput);
    // activation function
    outputs = this.sigmoid(outputs);
    
    // start of learning calculations
    Matrix targets = Matrix.fromArray(awnser);
    
    // calculate output layer error
    Matrix outputErrors = Matrix.sub(outputs,targets);
    
    // calculate output gradiant
    Matrix outputGradients = this.dsigmoid(outputs);
    outputGradients.mult(outputErrors);
    outputGradients.mult(learningRate);
    
    // caclculate output deltas
    Matrix hiddenTranspose = Matrix.transpose(hidden);
    Matrix hiddenOutputDeltas = Matrix.dotProduct(outputGradients, hiddenTranspose);
    
    weightsHO.add(hiddenOutputDeltas);
    
    // calculate hidden layer errors
    Matrix hiddenErrors = Matrix.mult(Matrix.transpose(weightsHO), outputErrors);
    
    // calculate hidden gradiant
    Matrix hiddenGradients = this.dsigmoid(hidden);
    hiddenGradients.mult(hiddenErrors);
    hiddenGradients.mult(learningRate);
    
    // calculate hidden deltas
    Matrix inputTranspose = Matrix.transpose(inputs);
    Matrix inputHiddenDeltas = Matrix.dotProduct(hiddenGradients, inputTranspose);
    
    weightsIH.add(inputHiddenDeltas);
  }
  
  /* sigmoid function for values between -1 and 1 */
  public Matrix sigmoid(Matrix value){
    for(int i = 0; i < value.rows; i++){
      for(int j = 0; j < value.cols; j++){
        value.data[i][j] = (float)(1/ (1 + Math.exp(-value.data[i][j])));
      }
    }
    return value;
  }
  /* dsigmoid function for values between -1 and 1 */
  public Matrix dsigmoid(Matrix value){
    for(int i = 0; i < value.rows; i++){
      for(int j = 0; j < value.cols; j++){
        value.data[i][j] = (float)(value.data[i][j] * (1 - value.data[i][j]));
      }
    }
    return value;
  }
  
}