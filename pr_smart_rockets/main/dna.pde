class DNA{
  
  PVector[] genes = new PVector[maxLifetime];
  
  DNA(PVector[] _genes){
    if(_genes != null){
      genes = _genes;
    }else{
      for(int i = 0; i < maxLifetime; i++){
        genes[i] = PVector.random2D();
      }
    }
    
  }
  
  DNA scrambleDNA(DNA partner){
    int mid = floor(random(0, maxLifetime));
    PVector[] newgenes = new PVector[maxLifetime];
    for(int i = 0; i < lifetime; i++){
      if(i > mid){
        newgenes[i] = genes[i];
      }else{
        newgenes[i] = partner.genes[i];
      }
    }
    DNA dna = new DNA(newgenes);
    dna.mutation();
    return dna;
  }
  
  void mutation(){
    for(int i = 0; i < lifetime; i++){
      if(random(1) < 0.01){
        genes[i] = PVector.random2D();
      }
    }
  }
  
}