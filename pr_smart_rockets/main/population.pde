class Population{
  
  Rocket[] rockets;
  ArrayList<Rocket> matingpool = new ArrayList<Rocket>();
  
  Population(){
    rockets = new Rocket[maxPopulation];
    for(int i = 0; i < maxPopulation; i++){
      rockets[i] = new Rocket(null);
    }
  }
  
  void run(){
    for(int i = 0; i < maxPopulation; i++){
      if(!rockets[i].crash){
        rockets[i].applyForce(rockets[i].dna.genes[lifetime]);
        rockets[i].update();
        rockets[i].show();
        //rockets[i].drawLine();
      }else{
        rockets[i].show();
      }
    }
  }
  
  void evaluate(){
    matingpool = new ArrayList<Rocket>();
    float maxFit = 0;
    for(int i = 0; i < maxPopulation; i++){
      rockets[i].calcFitness();
      if(rockets[i].fitness > maxFit){
        maxFit = rockets[i].fitness;
      }
    }
    
    
    for(int i = 0; i < maxPopulation; i++){
      rockets[i].fitness /= maxFit;
    }
    
    for(int i = 0; i < maxPopulation; i++){
      int size = round(rockets[i].fitness * 100);  
      for(int j = 0; j < size; j++){
        matingpool.add(rockets[i]);
      }
    }
  }
  
  void selection(){
    Rocket[] newRockets = new Rocket[maxPopulation];
    for(int i = 0; i < maxPopulation; i++){
      DNA parentA = matingpool.get(round(random(matingpool.size() - 1))).dna;
      DNA parentB = matingpool.get(round(random(matingpool.size() - 1))).dna;
      
      newRockets[i] = new Rocket(parentA.scrambleDNA(parentB));
    }
    rockets = newRockets;
  }
  
}