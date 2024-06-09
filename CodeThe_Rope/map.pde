public class Map {
  private ArrayList <Rope> ropes;
  private ArrayList <Spike> spikes;
  private Candy c;
  private Goal g;
  private double time;
  private boolean end;

  public Map(int index) {
    if (index ==1) {
      g = new Goal(500, 500, 50);
      spikes = new  ArrayList <Spike>();
      spikes.add(new Spike(80, 750));
      ropes = new  ArrayList <Rope>();
      PVectorD P1 = new PVectorD(100, 250);
      PVectorD P2 = new PVectorD(300, 450);
      PVectorD P3 = new PVectorD(500, 250);
      ropes.add(new Rope(this, P1, new PVectorD(P2), 1.2, 5, 50));
      ropes.add(new Rope(this, P3, new PVectorD(P2), 1.7, 5, 50));
      ropes.get(0).getEndpointB().setMovable(true);
      ropes.get(1).getEndpointB().setMovable(true);
      c = new Candy((float) P2.x, (float) P2.y, 0, 0, 10, 40);
      c.link(ropes.get(0).getEndpointB());
      c.link(ropes.get(1).getEndpointB());
    } else {
    }
  }
  
  
  public void addRope(Rope r) {
    ropes.add(r);
  }
  
  public void display() {
    for (int i = 0; i < ropes.size(); i++) {
      ropes.get(i).display();
    }
    c.display();
    for (int i = 0; i < spikes.size(); i++) {
      spikes.get(i).display();
    }
    g.display();
  }

  public void move() {
    if ((youWin() || youLose()) && !end){
      ArrayList <RopeNode> links = c.getLinks();
      for(int i = links.size() - 1; i > -1; i--) c.unlink(links.get(i));
      end = true;
    }
    time +=  dt;
    for (int i = 0; i < 2000; i++) {
      for (int j = 0; j < ropes.size(); j++) {
        ropes.get(j).move();
      }
      if (!end) c.move();
    }
  }

  public void mouseMovement(float startX, float startY, float endX, float endY) {
    for (int i = ropes.size() - 1; i > -1; i--) ropes.get(i).cut(startX, startY, endX, endY);
  }

  private boolean youWin(){
    if(c.calcDistance(g) < (g.getRadius() + c.getRadius()) / 2){
      text("you win", 100, 100);
      return true;
    }
    return false;
  }
  
  private boolean youLose() {
    boolean lose = c.getLinks().size() == 0 && c.offTheMap();
    for (int i = 0; i < spikes.size() && !lose; i++) {
      Spike s = spikes.get(i);
      lose = c.calcDistance(s) < (s.getRadius() + c.getRadius()) / 2;
    }
    if (lose) text("you lose", 100, 100);
    return lose;
  }
}
