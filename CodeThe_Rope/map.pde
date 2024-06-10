public class Map {
  private ArrayList <Bubble> bubbles = new ArrayList <Bubble>();
  private ArrayList <Connector> connectors = new ArrayList <Connector>();
  private ArrayList <Rope> ropes = new ArrayList <Rope>();
  private ArrayList <Spike> spikes = new ArrayList <Spike>();
  private ArrayList <Star> stars = new ArrayList <Star>();
  private Candy c;
  private Bubble currBubble = null;
  private Goal g;
  private double time;
  private int score;
  private int end;

  public Map(int index) {
    if (index == 1) {
      PVectorD P1 = new PVectorD(400, 100);
      PVectorD P2 = new PVectorD(800, 50);
      PVectorD P3 = new PVectorD(400, 250);
      Rope r0 = new Rope(this, P1, new PVectorD(P2), 1, 5, 50);
      Rope r1 = new Rope(this, P3, new PVectorD(P2), 1, 5, 50);
      c = new Candy((float) P2.x, (float) P2.y, 0, 0, 7);
      ropes.add(r0);
      ropes.add(r1);
      for (int i = 0; i < ropes.size(); i++) {
        ropes.get(i).getEndpointB().setMovable(true);
        c.link(ropes.get(i).getEndpointB());
      }
      g = new Goal(500, 300);
      bubbles.add(new Bubble(600, 400));
      connectors.add(new Connector(500, 750));
      spikes.add(new Spike(80, 750));
      stars.add(new Star(600, 750));
    }
    if (index == 4) {
      PVectorD P1 = new PVectorD(400, 100);
      PVectorD P2 = new PVectorD(800, 50);
      PVectorD P3 = new PVectorD(400, 250);
      Rope r0 = new Rope(this, P1, new PVectorD(P2), 1, 5, 50);
      Rope r1 = new Rope(this, P3, new PVectorD(P2), 1, 5, 50);
      c = new Candy((float) P2.x, (float) P2.y, 0, 0, 7);
      ropes.add(r0);
      ropes.add(r1);
      for (int i = 0; i < ropes.size(); i++) {
        ropes.get(i).getEndpointB().setMovable(true);
        c.link(ropes.get(i).getEndpointB());
      }
      g = new Goal(500, 300);
      bubbles.add(new Bubble(600, 400));
      connectors.add(new Connector(500, 750));
      spikes.add(new Spike(80, 750));
      stars.add(new Star(600, 750));
    }
  }
  
    
  public int getEnd(){
    return end;
  }

  public void addRope(Rope r) {
    ropes.add(r);
  }

  public void display() {
    g.display();
    for (int i = 0; i < stars.size(); i++) {
      stars.get(i).display();
    }
    for (int i = 0; i < ropes.size(); i++) {
      ropes.get(i).display();
    }
    for (int i = 0; i < connectors.size(); i++) {
      connectors.get(i).display();
    }
    c.display();
    for (int i = 0; i < bubbles.size(); i++) {
      bubbles.get(i).display();
    }
    for (int i = 0; i < spikes.size(); i++) {
      spikes.get(i).display();
    }
    fill(color(255, 255, 255));
    text("Score:" + score, 100, 50);
  }

  public void move() {
    if (end == -1 || end == 1) {
      ArrayList <RopeNode> links = c.getLinks();
      for (int i = links.size() - 1; i > -1; i--) c.unlink(links.get(i));
    }
    time += dt;
    for (int i = 0; i < 3000; i++) {
      for (int j = 0; j < ropes.size(); j++) {
        ropes.get(j).move();
      }
      if (end == 0) {
        c.move();
        connectCandy();
      }
    }
    collect();
    linkBubble();
  }

  public void mouseMovement(float startX, float startY, float endX, float endY) {
    for (int i = ropes.size() - 1; i > -1; i--) ropes.get(i).cut(startX, startY, endX, endY);
  }

  private void connectCandy() {
    for (int i = 0; i < connectors.size(); i++) {
      Connector cnt = connectors.get(i);
      if (!cnt.getConnected() && c.calcDistance(cnt) <= cnt.getConnectRadius() + c.getRadius()) {
        cnt.setConnected(true);
        Rope r = new Rope(this, new PVectorD(cnt.getPosition()), new PVectorD(c.getPosition()), 1, 5, 10);
        ropes.add(r);
        c.link(r.getEndpointB());
      }
    }
  }

  private void linkBubble() {
    for (int i = 0; i < bubbles.size() && currBubble == null; i++) {
      Bubble b = bubbles.get(i);
      if (c.calcDistance(b) <= 3 * (b.getRadius() + c.getRadius()) / 4) {
        b.connect(c);
        currBubble = b;
      }
    }
  }

  public boolean pop(float x, float y) {
    if (currBubble != null && Math.pow(x - currBubble.getPosition().x, 2) + Math.pow(y - currBubble.getPosition().y, 2) <= Math.pow(currBubble.getRadius(), 2)) {
      currBubble.pop();
      bubbles.remove(currBubble);
      currBubble = null;
      return true;
    }
    return false;
  }

  private void collect() {
    for (int i = stars.size() - 1; i > -1; i--) {
      Star s = stars.get(i);
      if (c.calcDistance(s) <= s.getRadius() + c.getRadius()) {
        stars.remove(i);
        score++;
      }
    }
  }

  private void youWin() {
    textSize(50);
    if (c.calcDistance(g) <= g.getRadius() + c.getRadius()) {
      end = 1;
    }
  }

  private void youLose() {
    textSize(50);
    Bubble b = currBubble;
    boolean lose = c.getLinks().size() == 0 && (c.getPosition().x + c.getRadius() < 0 && width < c.getPosition().x - c.getRadius() || c.getPosition().y + c.getRadius() < 0 || height < c.getPosition().y - c.getRadius())
      || b != null && b.getPosition().y + b.getRadius() < 0;
    for (int i = 0; i < spikes.size() && !lose; i++) {
      Spike s = spikes.get(i);
      lose = c.calcDistance(s) <= (s.getRadius() + c.getRadius()) / 2;
    }
    if (lose) {
      gravity.set(0, Math.abs(gravity.y));
      end = -1;
    }
  }
}
