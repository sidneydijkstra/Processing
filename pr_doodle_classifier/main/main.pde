
NeuralNetworkData[] cat_data_train;
NeuralNetworkData[] cat_data_test;
NeuralNetworkData[] cake_data_train;
NeuralNetworkData[] cake_data_test;
NeuralNetworkData[] cow_data_train;
NeuralNetworkData[] cow_data_test;

NeuralNetwork brain;

NeuralNetworkData[] trainData;
NeuralNetworkData[] testData;

ProssesDataFiles prossesor;

void setup(){
  size(400, 400);
  prossesor = new ProssesDataFiles();
  
  // create .nnd files from .npy files
  //ProssesDataFiles cat = new ProssesDataFiles("data/cat_data.npy", "cat_train_data.nnd", 784, 80, 1000);
  //ProssesDataFiles cake = new ProssesDataFiles("data/cake_data.npy", "cake_train_data.nnd", 784, 80, 1000);
  //ProssesDataFiles cow = new ProssesDataFiles("data/cow_data.npy", "cow_train_data.nnd", 784, 80, 1000);
  
  // setup training and testing data
  cat_data_train = prossesor.loadDataFile("cat_train_data.nnd", new float[]{1, 0, 0}, 0, 800);
  cat_data_test = prossesor.loadDataFile("cat_train_data.nnd", new float[]{1, 0, 0}, 800, 1000);
  cake_data_train = prossesor.loadDataFile("cake_train_data.nnd", new float[]{0, 1, 0}, 0, 800);
  cake_data_test = prossesor.loadDataFile("cake_train_data.nnd", new float[]{0, 1, 0}, 800, 1000);
  cow_data_train = prossesor.loadDataFile("cow_train_data.nnd", new float[]{0, 0, 1}, 0, 800);
  cow_data_test = prossesor.loadDataFile("cow_train_data.nnd", new float[]{0, 0, 1}, 800, 1000);
  
  // setup the arrays
  trainData = prossesor.shuffleArray((NeuralNetworkData[])concat(concat(cat_data_train, cake_data_train), cow_data_train));
  testData = prossesor.shuffleArray((NeuralNetworkData[])concat(concat(cat_data_test, cake_data_test), cow_data_test));
  
  // create neuralnetwork
  brain = new NeuralNetwork(784, 256, 3);
  
  textSize(23);
  text("Training", 100, 100);
  
  if(false){ // true for local training - false for loading trained file
    // train network form '20' times 
    for(int j = 0; j < 20; j++){
      print("Training " + trainData.length + " times [" + (j+1) + "]\n");
      for(int i = 0; i < trainData.length; i++){
        brain.train(trainData[i]);
      }
      
      // shuffle train data after every test
      trainData = prossesor.shuffleArray(trainData);
    }
    brain.saveNetwork("neuralnetwork_data.nn");
  }else{
    String filename = "neuralnetwork_data_doodle_84%.nn";
    print("loaded .nn file -> [" + filename + "]\n");
    brain.loadNetwork(filename);
  }
  
  
  
  // test the trained network with the testing data
  print("Testing " + testData.length + " times"); //<>//
  int correct = 0;
  for(int i = 0; i < testData.length; i++){
      float[] output = brain.predict(testData[i]); //<>//
      float max = max(output);
      for(int j = 0; j < testData[i].output.length; j++){
        if(testData[i].output[j] == 1){
          if(output[j] == max){
            correct++;
          }
          continue;
        }
      }
  }
  print("\nPrecent: " + ((float)correct / testData.length));
  
  currentImage = 0;
  noLoop();
}

void keyPressed(){
  redraw();
}

int currentImage;
int goodGuessedImages;
void draw(){
  // guess image
  String typeNameComplete = "null";
  String typeNameGuess = "null";
  float[] output = brain.predict(testData[currentImage]);
  float max = max(output);
  for(int j = 0; j < testData[currentImage].output.length; j++){
      if(testData[currentImage].output[j] == 1){
        typeNameComplete = j == 0 ? "cat!" : j == 1 ? "cake!" : "cow!";
      }
      if(output[j] == max){
        typeNameGuess = j == 0 ? "cat!" : j == 1 ? "cake!" : "cow!";
      }
  }
  
  // set background basses on guess
  color c = color(255, 0, 0);
  if(typeNameComplete == typeNameGuess){
    c = color(0, 255, 0);
    goodGuessedImages++;
  }
  background(c);
  
  // draw image
  PImage img = createImage(28, 28, RGB);
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) { 
    int b = round(map(testData[currentImage].input[i], 0, 1, 0, 255)); 
    img.pixels[i] = color(b);
  }
  img.updatePixels();
  image(img, width/2 - 50, 10, 100, 100);
  
  // set text
  textSize(23);
  text(typeNameGuess, 50, 50);
  text(typeNameComplete, 300, 50);
  text(map(goodGuessedImages, 0, currentImage == 0 ? 1 : currentImage, 0, 100) + "%", 50, 150);
  
  // goto next image
  currentImage++;
  if(currentImage >= testData.length){
    currentImage = 0;
    goodGuessedImages = 0;
  }
}