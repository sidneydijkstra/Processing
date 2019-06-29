

NeuralNetwork brain;
Epoch epoch;


void setup(){
  size(800, 800);
  
  // create the neural network
  brain = new NeuralNetwork(2, 8, 1);
  
  // create the training data
  epoch = new Epoch();
  epoch.addTrainingData(new NeuralNetworkData(new float[]{1, 1}, new float[]{0}));
  epoch.addTrainingData(new NeuralNetworkData(new float[]{0, 0}, new float[]{0}));
  epoch.addTrainingData(new NeuralNetworkData(new float[]{1, 0}, new float[]{1}));
  epoch.addTrainingData(new NeuralNetworkData(new float[]{0, 1}, new float[]{1}));
  
}

void draw(){
  background(0);
  
  int size = 20;
  for(int y = 0; y < size; y++){
    for(int x = 0; x < size; x++){
      float[] value = new float[2];
      value[0] = map(x, 0, size, 0.0f, 1.0f);
      value[1] = map(y, 0, size, 0.0f, 1.0f);
      float guess = brain.predict(value)[0];
      fill(guess * 255);
      rect(x * (width/size), y * (height/size), (width/size), (height/size));
      fill(0, 0, 255);
      text(guess, x * (width/size), y * (height/size) + ((height/size)/2));
    }
  }
  
  for(int i = 0; i < 50; i++){
    this.train(epoch);
  }
  
}

public void train(Epoch epoch){
  NeuralNetworkData[] data = epoch.getData(true);
  for(int i = 0; i < data.length; i++){
    brain.train(data[i]);
  }
}