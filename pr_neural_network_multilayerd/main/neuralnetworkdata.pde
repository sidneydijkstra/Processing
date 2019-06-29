public class NeuralNetworkData{
  
  float[] input;
  float[] output;
  
  public NeuralNetworkData(){
    this.input = new float[0];
    this.output = new float[0];
  }
  
  public NeuralNetworkData(float[] input){
    this.input = input;
    this.output = new float[0];
  }
  
  public NeuralNetworkData(float[] input, float[] output){
    this.input = input;
    this.output = output;
  }
  
  public void createData(float[] input, float[] output){
    this.input = input;
    this.output = output;
  }
  
}