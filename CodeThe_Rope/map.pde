public class Map {
  ArrayList<spike> spikes;
  ArrayList<Rope> ropes;
  goal g;
  Candy c;
  public Map(int index) {
    if (index==1) {
      g=new goal(500, 500, 50);
      c=new Candy(500, 100, 0, 0, 10, 40);
      spikes=new ArrayList<spike>();
      spikes.add(new spike(80, 750));
      ropes=new ArrayList<Rope>();
      PVectorD P1 = new PVectorD(400, 200);
      PVectorD P2 = new PVectorD(600, 250);
      ropes.add(new Rope(this, demoP1, demoP2, demoLFactor, demoMass, demoNumNodes));
      ropes.get(0).setColor(color(200, 320, 160));
      c.link(ropes.get(0).getEndpointB());
    } else {
      c=new Candy(100, 100, 0, -1, 10, 40);
      g=new goal(100, 100, 50);
    }
  }
  
  public void display() {
    c.display();
    g.display();
    for (int i=0; i<spikes.size(); i++) {
      spikes.get(i).display();
    }
    for (int i=0; i<ropes.size(); i++) {
      ropes.get(i).display();
    }
  }
  
  public void move() {
    for (int i=0; i<ropes.size(); i++) {
      ropes.get(i).move();
    }
    if (youWin()) {
      text("you win", 100, 100);
    } else if (youLose()) {
      text("you lose", 100, 100);
    } else {  
      c.applyForce(gravity);
    }
  }
  
  public void addRope(Rope r){
    ropes.add(r);
  }
  
  public void mouseMovement(float startX, float startY, float endX, float endY) {
    int currSize = ropes.size();
    for (int i=0; i<currSize; i++) {
      Rope r = ropes.get(i);
      r.cut(startX, startY, endX, endY);
    }
  }
  
  public boolean doesIntersect(float x1, float y1, float x2, float y2, float x3, float y3, float radius) {
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

  public boolean youWin() {
    if (c.calcDistance(g)<(g.getRadius()+c.radius)/2) {
      c.unlink();
      return true;
    }
    return false;
  }

  public boolean youLose() {
    if (c.offTheMap()) {
      return true;
    }
    for (int i=0; i<spikes.size(); i++) {
      spike s=spikes.get(i);
      if (c.calcDistance(s)<(s.getRadius()+c.radius)/2) {
        return true;
      }
    }
    return false;
  }
}
