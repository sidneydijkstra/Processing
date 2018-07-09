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
  
  public float[] predict(NeuralNetworkData data){
    return this.predict(data.input);
  }
  
  public float[] predict(float[] input){
    // create the input matrix
    Matrix inputs = Matrix.fromArray(input);
    
    // generating hidden outputs
    Matrix hidden = Matrix.dot(weightsIH, inputs);
    hidden.add(biasHidden);
    // activation function
    hidden = this.sigmoid(hidden);
    
    // generating output outputs
    Matrix output = Matrix.dot(weightsHO, hidden);
    output.add(biasOutput);
    // activation function
    output = this.sigmoid(output);
    
    // return the output
    return Matrix.toFloatArray(output);
  }
  
  public void train(NeuralNetworkData data){
    this.train(data.input, data.output);
  }
  
  public void train(float[] inputArray, float[] targetArray){
    // get input in matrix
    Matrix inputs = Matrix.fromArray(inputArray);
    
    // generating the hidden outputs
    Matrix hidden = Matrix.dot(weightsIH, inputs);
    hidden.add(this.biasHidden);
    hidden = this.sigmoid(hidden);
    
    // generating the hidden outputs
    Matrix outputs = Matrix.dot(weightsHO, hidden);
    outputs.add(this.biasOutput);
    outputs = this.sigmoid(outputs);
    
    // get target in array
    Matrix targets = Matrix.fromArray(targetArray);
    
    // calculate output error
    Matrix output_errors = Matrix.sub(targets, outputs);
    
    // calculate output gradient
    Matrix output_gradients = this.dsigmoid(outputs);
    output_gradients.mult(output_errors);
    output_gradients.mult(this.learningRate);
    
    // calculate hidden->output deltas
    Matrix hidden_transpose = Matrix.transpose(hidden); //<>//
    Matrix weightHO_deltas = Matrix.dot(output_gradients, hidden_transpose);
    
    // adjust weights
    this.weightsHO.add(weightHO_deltas);
    this.biasOutput.add(output_gradients);

    // Calculate the hidden layer errors
    Matrix weightsHO_transpose = Matrix.transpose(this.weightsHO);
    Matrix hidden_errors = Matrix.dot(weightsHO_transpose, output_errors);
    
    //  Calculate hidden gradient
    Matrix hiddenGradients = this.dsigmoid(hidden);
    hiddenGradients.mult(hidden_errors); // <-- hidden_errors is not right size for 'dot()' function
    hiddenGradients.mult(this.learningRate);

    // Calcuate input->hidden deltas
    Matrix inputs_transpose = Matrix.transpose(inputs);
    Matrix weightIH_deltas = Matrix.dot(hiddenGradients, inputs_transpose);
    
    // adjust weights
    this.weightsIH.add(weightIH_deltas); //<>//
    this.biasHidden.add(hiddenGradients); //<>//
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