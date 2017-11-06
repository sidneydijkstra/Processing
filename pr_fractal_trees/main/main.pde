
ArrayList<Branch> branches = new ArrayList<Branch>();
int branchCount = 5;

void setup(){
  size(400, 600);
  
  branches.add(new Branch(new PVector(width/2, height), new PVector(width/2, height-100)));
}

void draw(){
  background(0);
  
  for(int i = 0; i < branches.size(); i++){
    branches.get(i).show();
    branches.get(i).jitter();
  }
}

void keyPressed(){
  if(key == 'x'){
    int size = branches.size();
    for(int y = 0; y < size; y++){
      if(!branches.get(y).grown){
        branches.add(branches.get(y).branchLeft());
        branches.add(branches.get(y).branchRight());
        
        branches.get(y).grown = true;
      }
    }
  }
}