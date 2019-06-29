import java.util.Collections;

public class Epoch{
  
  ArrayList<NeuralNetworkData> data;
  
  public Epoch(){
    data = new ArrayList<NeuralNetworkData>();
  }
  
  public Epoch(NeuralNetworkData[] tData){
    data = new ArrayList<NeuralNetworkData>();
    this.addTrainingData(tData);
  }
  
  public void addTrainingData(NeuralNetworkData tData){
    this.data.add(tData);
  }
  public void addTrainingData(NeuralNetworkData[] tData){
    for(int i = 0; i < tData.length; i++){
      this.data.add(tData[i]);
    }
  }
  
  public NeuralNetworkData[] getData(Boolean shuffle){
    if(shuffle){
      Collections.shuffle(data);
    }
    
    return data.toArray(new NeuralNetworkData[data.size()]);
  }
  
}