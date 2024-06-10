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
  private int score, end;

  public Map(int index) {
    if (index == 1) {
      PVectorD P1 = new PVectorD(750, 50);
      PVectorD P2 = new PVectorD(750, 100);
      //this is the map, p1 the origin node, p2 is the candy, 1, 5 is the mass, 50 is the number of nodes
      Rope r0 = new Rope(this, P1, new PVectorD(P2), 1, 2, 25);
      c = new Candy((float) P2.x, (float) P2.y, 0, 0, 7);
      ropes.add(r0);
      for (int i = 0; i < ropes.size(); i++) {
        ropes.get(i).getEndpointB().setMovable(true);
        c.link(ropes.get(i).getEndpointB());
      }
      g = new Goal(750, 800);
      stars.add(new Star(750, 300));
      stars.add(new Star(750, 450));
      stars.add(new Star(750, 600));
    }
    if (index == 2) {
      PVectorD P1 = new PVectorD(200, 100);
      PVectorD P2 = new PVectorD(800, 200);
      PVectorD P3 = new PVectorD(900, 100);
      Rope r0 = new Rope(this, P1, new PVectorD(P2), 1, 1, 50);
      Rope r1 = new Rope(this, P3, new PVectorD(P2), 1, 1, 50);
      c = new Candy((float) P2.x, (float) P2.y, 0, 0, 7);
      ropes.add(r0);
      ropes.add(r1);
      for (int i = 0; i < ropes.size(); i++) {
        ropes.get(i).getEndpointB().setMovable(true);
        c.link(ropes.get(i).getEndpointB());
      }
      g = new Goal(80, 750);
      stars.add(new Star(670, 420));
      stars.add(new Star(550, 582));
      stars.add(new Star(322, 704));
    }
    if (index == 3) {
      PVectorD P1 = new PVectorD(400, 100);
      PVectorD P3 = new PVectorD(800, 100);
      PVectorD P4 = new PVectorD(700, 272);
      //candy
      PVectorD P2 = new PVectorD(600, 200);
      Rope r0 = new Rope(this, P1, new PVectorD(P2), 1, 1, 50);
      Rope r1 = new Rope(this, P3, new PVectorD(P2), 1, 1, 50);
      Rope r2 = new Rope(this, P4, new PVectorD(P2), 3, 5, 50);
      c = new Candy((float) P2.x, (float) P2.y, 0, 0, 7);
      ropes.add(r0);
      ropes.add(r1);
      ropes.add(r2);
      for (int i = 0; i < ropes.size(); i++) {
        ropes.get(i).getEndpointB().setMovable(true);
        c.link(ropes.get(i).getEndpointB());
      }
      g = new Goal(648, 695);
      stars.add(new Star(772, 433));
      stars.add(new Star(760, 563));
      stars.add(new Star(758, 665));
      spikes.add(new Spike(616, 582));
    }
    if (index == 4) {
      PVectorD P1 = new PVectorD(750, 300);
      PVectorD P2 = new PVectorD(900, 300);
      PVectorD P3 = new PVectorD(900, 50);
      Rope r0 = new Rope(this, P1, new PVectorD(P2), 1, 1, 50);
      Rope r1 = new Rope(this, P3, new PVectorD(P2), 1, 1, 50);
      c = new Candy((float) P2.x, (float) P2.y, 0, 0, 7);
      ropes.add(r0);
      ropes.add(r1);
      for (int i = 0; i < ropes.size(); i++) {
        ropes.get(i).getEndpointB().setMovable(true);
        c.link(ropes.get(i).getEndpointB());
      }
      g = new Goal(800, 802);
      connectors.add(new Connector(867, 537, 150));
      stars.add(new Star(784, 614));
      stars.add(new Star(946, 614));
      stars.add(new Star(800, 697));
    }
    if (index == 5) {
      PVectorD P1 = new PVectorD(20, 20);
      PVectorD P2 = new PVectorD(200, 50);
      PVectorD P3 = new PVectorD(800, 20);
      PVectorD P4 = new PVectorD(800, 700);
      Rope r0 = new Rope(this, P1, new PVectorD(P2), 1, 5, 50);
      Rope r1 = new Rope(this, P3, new PVectorD(P2), 1, 5, 50);
      Rope r2 = new Rope(this, P4, new PVectorD(P2), 1, 5, 50);
      c = new Candy((float) P2.x, (float) P2.y, 0, 0, 7);
      ropes.add(r0);
      ropes.add(r1);
      ropes.add(r2);
      for (int i = 0; i < ropes.size(); i++) {
        ropes.get(i).getEndpointB().setMovable(true);
        c.link(ropes.get(i).getEndpointB());
      }
      g = new Goal(1180, 580);
      bubbles.add(new Bubble(760, 620));
      connectors.add(new Connector(1250, 200, 150));
      spikes.add(new Spike(1100, 610));
      stars.add(new Star(760, 620));
      stars.add(new Star(1091, 200));
      stars.add(new Star(1391, 268));
    }
    if (index == 6) {
      PVectorD P1 = new PVectorD(600, 25);
      PVectorD P2 = new PVectorD(200, 50);
      PVectorD P3 = new PVectorD(400, 75);
      Rope r0 = new Rope(this, P1, new PVectorD(P2), 1, 5, 50);
      Rope r1 = new Rope(this, P3, new PVectorD(P2), 1, 5, 50);
      c = new Candy((float) P2.x, (float) P2.y, 0, 0, 7);
      ropes.add(r0);
      ropes.add(r1);
      for (int i = 0; i < ropes.size(); i++) {
        ropes.get(i).getEndpointB().setMovable(true);
        c.link(ropes.get(i).getEndpointB());
      }
      g = new Goal(700, 300);
      bubbles.add(new Bubble(600, 400));
      bubbles.add(new Bubble(840, 800));
      connectors.add(new Connector(1000, 200, 130));
      spikes.add(new Spike(450, 300));
      spikes.add(new Spike(840, 600));
      stars.add(new Star(840, 800));
      stars.add(new Star(699, 397));
      stars.add(new Star(1091, 268));
    }
  }

  public int getScore() {
    return score;
  }

  public int getEnd() {
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
  }

  public void move() {
    youWin();
    youLose();
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
      print("XDXDXD");
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
    if (c.calcDistance(g) <= g.getRadius() + c.getRadius()) {
      gravity = new PVectorD(0, 5);
      end = 1;
    }
  }

  private void youLose() {
    Bubble b = currBubble;
    boolean lose = c.getLinks().size() == 0 && (c.getPosition().x + c.getRadius() < 0 && width < c.getPosition().x - c.getRadius() || c.getPosition().y + c.getRadius() < 0 || height < c.getPosition().y - c.getRadius() && currBubble == null)
      || b != null && b.getPosition().y + b.getRadius() < 0;
    for (int i = 0; i < spikes.size() && !lose; i++) {
      Spike s = spikes.get(i);
      lose = c.calcDistance(s) <= s.getRadius() + c.getRadius();
    }
    if (lose) {
      gravity = new PVectorD(0, 5);
      end = -1;
    }
  }
}
