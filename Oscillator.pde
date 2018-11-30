class Oscillator{
  public PVector pos;
  public PVector trg;
  public int resolution;
  
  public Oscillator(int resolution){
    pos = new PVector(width / 2, height / 2);
    trg = pos.copy();
    this.resolution = resolution;
  }
  
  public void SetTarget(int x, int y){
    trg.set(x, y);
  }
  
  public void SetTarget(PVector v){
    trg.set(v.x, v.y);
  }
  
  public boolean MoveToTarget(){
    
    for (int i = 0; i < resolution; i++){
      
    }
    
    return (pos.x == trg.x && pos.y == trg.y) ? true : false;
  }
}
