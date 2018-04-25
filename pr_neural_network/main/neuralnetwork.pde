public class NeuralNetwork{
  
  int inputNodesSize;
  int hiddenNodesSize;
  int outputNodesSize;
  
  Matrix weightsIH;
  Matrix weightsHO;
  
  Matrix biasHidden;
  Matrix biasOutput;
  
  public NeuralNetwork(int inputNodesSize, int hiddenNodesSize, int outputNodesSize){
    this.inputNodesSize = inputNodesSize;
    this.hiddenNodesSize = hiddenNodesSize;
    this.outputNodesSize = outputNodesSize;
    
    // create the weights matrix's
    weightsIH = new Matrix(hiddenNodesSize, inputNodesSize);
    weightsHO = new Matrix(outputNodesSize, hiddenNodesSize);
    
    // randomize the matrix's ( there is a way to get good working random values TODO )
    weightsIH.randomize(-1,1);
    weightsHO.randomize(-1,1);
    
    // create the bias matrix's
    biasHidden = new Matrix(hiddenNodesSize, 1);
    biasOutput = new Matrix(outputNodesSize, 1);
  }
  
  public void feedForward(float[] input){
    
    Matrix hidden = new Matrix();
    
  }
  
}