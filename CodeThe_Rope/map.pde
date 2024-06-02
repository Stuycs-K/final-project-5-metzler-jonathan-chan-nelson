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
      c=new Candy(500, 100, -1, 0, 10, 40);
      spikes=new ArrayList<spike>();
      spikes.add(new spike(80,500));
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
  public void mouseMovement(int startX,int startY,int endX,int endY){
     if(doesIntersect(startX,startY,endX,endY,80,500,20)){
       text("THIS WORKS", 750,750);
     }
       
  }
  public boolean doesIntersect(double x1, double y1, double x2, double y2, double x3, double y3, double radius) {
        // Calculate the quadratic equation coefficients
        double dx = x2 - x1;
        double dy = y2 - y1;
        double fx = x1 - x3;
        double fy = y1 - y3;

        double a = dx * dx + dy * dy;
        double b = 2 * (fx * dx + fy * dy);
        double c = (fx * fx + fy * fy) - radius * radius;

        // Calculate the discriminant
        double discriminant = b * b - 4 * a * c;

        // Check if the discriminant is negative (no intersection)
        if (discriminant < 0) {
            return false;
        }

        // Calculate the two solutions for t
        discriminant = Math.sqrt(discriminant);
        double t1 = (-b - discriminant) / (2 * a);
        double t2 = (-b + discriminant) / (2 * a);

        // Check if either t1 or t2 is within the range [0, 1]
        if ((t1 >= 0 && t1 <= 1) || (t2 >= 0 && t2 <= 1)) {
            return true;
        }

        return false;
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
  
