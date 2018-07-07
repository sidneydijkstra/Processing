
public class TData{
  float[] input;
  float[] target;
  public TData(float inputA, float inputB, float target){
    this.input = new float[2];
    this.input[0] = inputA;
    this.input[1] = inputB;
    this.target = new float[1];
    this.target[0] = target;
  }
}

TData[] trainingData;

NeuralNetwork brain;

void setup(){
  noLoop();
  
  // create the neural network
  brain = new NeuralNetwork(2, 2, 1);
  
  // create the training data
  trainingData = new TData[5];
  trainingData[0] = new TData(1, 1, 1);
  trainingData[1] = new TData(0, 1, 1);
  trainingData[2] = new TData(0, 0, 0);
  trainingData[3] = new TData(1, 0, 0);
  trainingData[4] = new TData(0.5, 0.5, 0.5);
  
  // train the network
  for(int i = 0; i < 100000; i++){
    int index = floor(random(trainingData.length));
    brain.train(trainingData[index].input, trainingData[index].target);
  }
  
  for(int j = 0; j < trainingData.length; j++){
    TData data = trainingData[j];
    float[] output = brain.feedForward(data.input);
    print("(" + data.input[0] + " , " + data.input[1] + ")" + " brain output: " + output[0] + " [" + data.target[0] + "]\n");
  }
}