public class map{
  PVector gravity;
  ArrayList<spike> spikes;
  ArrayList<Rope> ropes;
  goal g;
  Candy c;
  int stars;
  public map(int index){
    if(index==1){
      g=new goal(500,500,50);
      c=new Candy(100, 100, -1, 0, 10, 40);
      spikes=new ArrayList<spike>();
      spikes.add(spike(500,100));
      ropes=new ArrayList<Rope>();
    }
    else{
      c=new Candy(100, 100, -1, 0, 10, 40);
      g=new goal(100,100,50);
    }
    gravity = new PVector(0, 6);
  }
  public void display(){
    g.display();
    c.display();
    for(int i=0;i<spikes.size();i++){
      spikes.get(i).display();
    }
    for(int i=0;i<ropes.size();i++){
      ropes.get(i).display();
    }
  }
  public void move(){
    if(youWin()){
      text("you win", 100,100);
    }
    else if(youLose()){
      text("you lose", 100,100);
    }
    else{
      c.move();
      c.applyForce(gravity);
    }
  }
  
  
  public boolean youWin(){
    if(c.calcDistance(g)<(g.getRadius()+c.radius)/2){
      return true;
    }
    return false;
  }
  
  public boolean youLose() {
    if(c.offTheMap()){
      return true;
    }
    for(int i=0;i<spikes.size();i++){
      spike s=spikes.get(i);
      if(c.calcDistance(s)<(s.getRadius()+c.radius)/2){
        return true;
      }
    }
    return false;
  }
}
  
