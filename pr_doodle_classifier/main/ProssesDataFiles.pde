public class ProssesDataFiles{
  
  public ProssesDataFiles(){}
  
  void convertNPYtoNND(String fileName, String saveName, int size, int offset, int amount){
    byte[] bytes = loadBytes(fileName);
    byte[] output = new byte[size*amount];
    for (int i = offset; i < output.length + offset; i++) { 
      output[i-offset] = bytes[i];
    }
    saveBytes(saveName, output);
  }
  
  public NeuralNetworkData[] loadDataFile(String fileName, float[] correct, int start, int end){
    byte[] bytes = loadBytes(fileName);
    
    int max = bytes.length / 784;
    end = max < end ? max : end;
    NeuralNetworkData[] nnd = new NeuralNetworkData[end-start];
    
    int currentbyte = start*784;
    for(int i = 0; i < nnd.length; i++){
      float[] input = new float[784];
      
      for(int b = 0; b < 784; b++){
        float data = bytes[currentbyte] & 0xff;
        input[b] = map(data, 0, 255, 0, 1);
        currentbyte++;
      }
      
      nnd[i] = new NeuralNetworkData(input, correct);
    }
    
    return nnd;
  }
  
  NeuralNetworkData[] shuffleArray(NeuralNetworkData[] array) {
    Random rng = new Random();
    // i is the number of items remaining to be shuffled.
    for (int i = array.length; i > 1; i--) {
      // Pick a random element to swap with the i-th element.
      int j = rng.nextInt(i);  // 0 <= j <= i-1 (0-based array)
      // Swap array elements.
      NeuralNetworkData tmp = array[j];
      array[j] = array[i-1];
      array[i-1] = tmp;
    }
    return array;
  }
  
}