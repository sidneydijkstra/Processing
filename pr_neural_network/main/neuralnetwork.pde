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
    Matrix hidden = Matrix.dot(weightsIH, inputs);
    //hidden.add(biasHidden);
    // activation function
    hidden = this.sigmoid(hidden);
    
    // generating output outputs
    Matrix output = Matrix.dot(weightsHO, hidden);
    //output.add(biasOutput);
    // activation function
    output = this.sigmoid(output);
    
    // return the output
    return Matrix.toFloatArray(output);
  }
  
  public void train(float[] inputArray, float[] targetArray){
    // normal feedforward calculations
    // create the input matrix
    /*
    Matrix inputs = Matrix.fromArray(inputArray);
    Matrix targets = Matrix.fromArray(targetArray);
    
    // generating hidden outputs
    Matrix hidden = Matrix.dotProduct(weightsIH, inputs);
    // activation function
    hidden = this.sigmoid(hidden);
    
    // generating output outputs
    Matrix outputs = Matrix.dotProduct(weightsHO, hidden);
    // activation function
    outputs = this.sigmoid(outputs);
    
    // start of learning calculations
    
    // calculate output layer error
    Matrix outputErrors = Matrix.sub(targets, outputs);
    
    // calculate hidden layer errors
    Matrix hiddenErrors = Matrix.dotProduct(Matrix.transpose(weightsHO), outputErrors);
    
    // calculate output gradiant
    Matrix outputGradients = this.dsigmoid(outputs);
    outputGradients.mult(outputErrors);
    outputGradients.mult(learningRate);
    
    // calculate hidden gradiant
    Matrix hiddenGradients = this.dsigmoid(hidden);
    hiddenGradients.mult(hiddenErrors);
    hiddenGradients.mult(learningRate);
    
    // caclculate output deltas
    Matrix hiddenTranspose = Matrix.transpose(hidden);
    Matrix hiddenOutputDeltas = Matrix.dotProduct(outputGradients, hiddenTranspose);
    weightsHO.add(hiddenOutputDeltas);
    biasOutput.add(outputGradients);
    
    // calculate hidden deltas
    Matrix inputTranspose = Matrix.transpose(inputs);
    Matrix inputHiddenDeltas = Matrix.dotProduct(hiddenGradients, inputTranspose);
    weightsIH.add(inputHiddenDeltas);
    biasHidden.add(hiddenGradients);
    
    // adjust the weights by deltas
    // adjust the bias by its deltas
    
    // adjust the weights by deltas
    // adjust the bias by its deltas
    */
    
    Matrix inputs = Matrix.fromArray(inputArray); //<>//
    Matrix targets = Matrix.fromArray(targetArray);
    
    Matrix hiddenInputs = Matrix.dot(weightsIH, inputs);
    Matrix hiddenOutputs = this.sigmoid(hiddenInputs);
    
    Matrix outputInputs = Matrix.dot(weightsHO, hiddenOutputs);
    Matrix outputs = this.sigmoid(outputInputs);
    
    // calculate the errors
    Matrix output_errors = Matrix.sub(targets, outputs);
    
    
    Matrix weightsTransposeHO = weightsHO.transpose();
    Matrix hidden_errors = Matrix.dot(weightsTransposeHO, outputs);
    
    // calculate output gradiant
    Matrix outputGradients = this.dsigmoid(outputs);
    outputGradients.mult(output_errors);
    outputGradients.mult(this.learningRate);
    
    // calculate hidden gradiant
    Matrix hiddenGradients = this.dsigmoid(hiddenOutputs);
    hiddenGradients.mult(hidden_errors);
    hiddenGradients.mult(this.learningRate);
    
    // Change in weights from HIDDEN --> OUTPUT
    Matrix hiddenOutputsTranspose = hiddenOutputs.transpose();
    Matrix deltaWOuput = Matrix.dot(outputGradients, hiddenOutputsTranspose);    
    this.weightsHO.add(deltaWOuput);
    
    // Change in weights from INPUT --> HIDDEN
    Matrix inputsTranspose = inputs.transpose();
    Matrix deltaWHidden = Matrix.dot(hiddenGradients, inputsTranspose);
    this.weightsIH.add(deltaWHidden);
    
    // idk??
    this.biasOutput.add(outputGradients);
    this.biasHidden.add(hiddenGradients);
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