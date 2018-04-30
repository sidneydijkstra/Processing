
NeuralNetwork brain;

void setup(){
  noLoop();
  
  brain = new NeuralNetwork(2, 2, 1);
  
  float[] inputs = {1 ,0};
  float[] targets = {1, 1};
  
  brain.train(inputs,targets);
  
  //print(output[0] + " [" + output.length + "]");
  
}

void draw(){

}