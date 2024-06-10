public class Map {
  private ArrayList <Connector> connectors;
  private ArrayList <Rope> ropes;
  private ArrayList <Spike> spikes;
  private Candy c;
  private Goal g;
  private double time;
  private boolean end;

  public Map(int index) {
    if (index == 1) {
      connectors = new ArrayList <Connector>();
      ropes = new ArrayList <Rope>();
      spikes = new ArrayList <Spike>();
      PVectorD P1 = new PVectorD(400, 100);
      PVectorD P2 = new PVectorD(800, 50);
      PVectorD P3 = new PVectorD(400, 250);
      Rope r0 = new Rope(this, P1, new PVectorD(P2), 1, 5, 10);
      Rope r1 = new Rope(this, P3, new PVectorD(P2), 1, 5, 10);      
      c = new Candy((float) P2.x, (float) P2.y, 0, 0, 7, 40);    
      ropes.add(r0);
      ropes.add(r1);
      for(int i = 0; i < ropes.size(); i++){
        ropes.get(i).getEndpointB().setMovable(true);
        c.link(ropes.get(i).getEndpointB());
      }
      g = new Goal(500, 300, 50);
      spikes.add(new Spike(80, 750));
      connectors.add(new Connector(500, 750));
    } 
    else {
      connectors = new ArrayList <Connector>();
      ropes = new ArrayList <Rope>();
      spikes = new ArrayList <Spike>();
      g = new Goal(500, 300, 50);
      PVectorD P2 = new PVectorD(800, 50);
      c = new Candy((float) P2.x, (float) P2.y, 0, 0, 7, 40);    
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
    for (int i = 0; i < connectors.size(); i++) {
      connectors.get(i).display();
    }
    g.display();
  }

  public void move() {
    if ((youWin() || youLose()) && !end) {
      ArrayList <RopeNode> links = c.getLinks();
      for (int i = links.size() - 1; i > -1; i--) c.unlink(links.get(i));
      end = true;
    }
    time += dt;
    for (int i = 0; i < 2000; i++) {
      for (int j = 0; j < ropes.size(); j++) {
        ropes.get(j).move();
      }
      if (!end) {
        c.move();
        connectCandy();
      }
    }
  }

  public void mouseMovement(float startX, float startY, float endX, float endY) {
    for (int i = ropes.size() - 1; i > -1; i--) ropes.get(i).cut(startX, startY, endX, endY);
  }
  
  private void connectCandy() {
    for (int i = 0; i < connectors.size(); i++) {
      Connector cnt = connectors.get(i);
      if (!cnt.getConnected() && c.calcDistance(cnt) <= (cnt.getConnectRadius() + c.getRadius()) / 2) {
        cnt.setConnected(true);
        Rope r = new Rope(this, new PVectorD(cnt.getPosition()), new PVectorD(c.getPosition()), 1, 5, 10);
        ropes.add(r);
        c.link(r.getEndpointB());
      }
    }
  }

  private boolean youWin() {
    if (c.calcDistance(g) <= (g.getRadius() + c.getRadius()) / 2) {
      text("You Won", 100, 100);
      return true;
    }
    return false;
  }

  private boolean youLose() {
    boolean lose = c.getLinks().size() == 0 && (c.getPosition().x + c.getRadius() < 0 && width < c.getPosition().x - c.getRadius() || c.getPosition().y + c.getRadius() < 0 || height < c.getPosition().y - c.getRadius());
    for (int i = 0; i < spikes.size() && !lose; i++) {
      Spike s = spikes.get(i);
      lose = c.calcDistance(s) <= (s.getRadius() + c.getRadius()) / 2;
    }
    if (lose) text("You Lost", 100, 100);
    return lose;
  }
}
