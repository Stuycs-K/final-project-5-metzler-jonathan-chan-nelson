public class Rope {
  private Map map;
  private RopeNode endpointA, endpointB;
  private double len;
  private double wid = 5;
  private int numNodes;
  private color col = color(222, 184, 135);

  public Rope(Map m, PVectorD P1, PVectorD P2, double lFactor, double ms, int n) {
    boolean reflect = P2.x < P1.x;
    boolean vertical = P1.x == P2.x;
    if (reflect) P2.x = 2 * P1.x - P2.x;
    if (vertical) {
      P1.invert();
      P2.invert();
    }
    map = m;
    len = lFactor * staticP.dist(P1, P2);
    numNodes = n;
    endpointA = new RopeNode(this, P1, ms);
    endpointB = new RopeNode(this, P2, ms);
    endpointA.setMovable(false);
    endpointB.setMovable(false);
    double d = Math.sqrt(Math.pow(len, 2) - Math.pow(-P2.y + P1.y, 2)) / (P2.x - P1.x);
    double dA = 0.000001;
    double A = 0.0001;
    while (d * (A + dA) > Math.sinh(A + dA))A += dA;
    double a = (P2.x - P1.x) / (2 * A);
    double b = ((P1.x + P2.x) / 2 - a * Math.log((1 + (P1.y - P2.y) / len) / (1 - (P1.y - P2.y) / len)) / 2);
    double c = (-P1.y - a * Math.cosh((P1.x - b) / a));
    if (reflect) P2.x = 2 * P1.x - P2.x;
    if (vertical) P2.invert();
    RopeNode r = endpointA;
    for (int i = 1; i < numNodes; i++) {
      RopeNode next;
      if (i == n - 1) next = endpointB;
      else {
        double integral = 0;
        double x = r.getPosition().x;
        if (reflect) x = 2 * P1.x - x;
        double dx = 0.1;
        while (integral < len / (numNodes - 1)) {
          integral += Math.sqrt(1 + Math.pow(Math.sinh((x - b) / a), 2)) * dx;
          x += dx;
        }
        PVectorD p = new PVectorD(x, -(a * Math.cosh((x - b) / a) + c));
        if (reflect) p.set(2 * P1.x - p.x, p.y);
        next = new RopeNode(this, p, ms);
      }
      r.setNext(next);
      next.setPrev(r);
      if (vertical) r.getPosition().invert();
      r = next;
    }
  }

  private Rope(RopeNode r, Rope rope) {
    numNodes = 0;
    endpointA = rope.getEndpointB();
    if (endpointA.getCandyLink() !=  null) endpointA.getCandyLink().unlink(endpointA);
    reverse(endpointA);
    endpointB = r;
    wid = rope.getWidth();
    len = (numNodes - 1) * rope.getLength() / (rope.getNumNodes() - 1);
    col = rope.getColor();
    map = rope.getMap();
  }

  private void reverse(RopeNode r) {
    if (r !=  null) {
      if (r == endpointA);
      RopeNode prev = r.getPrev();
      r.setPrev(r.getNext());
      reverse(prev);
      r.setNext(prev);
      numNodes++;
    }
  }

  public Map getMap() {
    return map;
  }

  public RopeNode getEndpointA() {
    return endpointA;
  }

  public RopeNode getEndpointB() {
    return endpointB;
  }

  public double getLength() {
    return len;
  }

  public double getWidth() {
    return wid;
  }

  public int getNumNodes() {
    return numNodes;
  }

  public color getColor() {
    return col;
  }

  public void setWidth(double w) {
    wid = w;
  }

  public void setColor(color c) {
    col = c;
  }

  public void display() {
    //noStroke();
    fill(col);
    display(endpointA);
  }

  private void display(RopeNode r) {
    if (r !=  null && r.getNext() !=  null) {
      PVectorD rPos = r.getPosition();
      PVectorD nextPos = r.getNext().getPosition();
      float angle = -atan((float) ((nextPos.y - rPos.y) / (rPos.x - nextPos.x)));
      float x = (float) staticP.add(rPos, nextPos).x / 2;
      float y = (float) staticP.add(rPos, nextPos).y / 2;
      float l = (float) staticP.dist(rPos, nextPos);
      translate(x, y);
      rotate(angle);
      rect(- l / 2, - (float) wid / 2, l, (float) wid);
      rotate(-angle);
      translate(-x, -y);
      if (r !=  endpointB.getPrev()) display(r.getNext());
    }
  }

  private boolean between(double v1, double v2, double v3) {
    return v1 <= v3 && v3 <= v2 || v2 <= v3 && v3 <= v1;
  }

  public void cut(float startX, float startY, float endX, float endY) {
    cut(endpointA, startX, startY, endX, endY, 1);
  }

  private void cut(RopeNode r, float startX, float startY, float endX, float endY, int i) {
    if (r !=  endpointB) {
      PVector start = new PVector(startX, startY);
      PVector end = new PVector(endX, endY);
      PVector rPos = r.getPosition().toPVector();
      PVector nextPos = r.getNext().getPosition().toPVector();
      PVector center = PVector.add(rPos, nextPos).div(2);
      float angle = atan((float) ((nextPos.y - rPos.y) / (rPos.x - nextPos.x)));
      float dist = PVector.dist(rPos, nextPos);
      start.sub(center);
      end.sub(center);
      start.set(new PVector(start.x * cos(angle) - start.y * sin(angle), start.x * sin(angle) + start.y * cos(angle)));
      end.set(new PVector(end.x * cos(angle) - end.y * sin(angle), end.x * sin(angle) + end.y * cos(angle)));
      start.add(center);
      end.add(center);
      boolean vertical = start.x == end.x;
      boolean horizontal = start.y == end.y;
      boolean inBox = false;
      if (!vertical && !horizontal) {
        double slope = (start.y - end.y) / (start.x - end.x);
        double passLeftY = slope * (center.x - dist / 2 - start.x) + start.y;
        double passRightY = slope * (center.x + dist / 2 - start.x) + start.y;
        double passTopX = (center.y + wid / 2 - start.y) / slope + start.x;
        double passBottomX = (center.y - wid / 2 - start.y) / slope + start.x;
        inBox = center.y - wid / 2 <= passLeftY && passLeftY <= center.y + wid / 2 && between(start.y, end.y, passLeftY)
          || center.y - wid / 2 <= passRightY && passRightY <= center.y + wid / 2 && between(start.y, end.y, passRightY)
          || center.x - dist / 2 <= passTopX && passTopX <= center.x + dist / 2 && between(start.x, end.x, passTopX)
          || center.x - dist / 2 <= passBottomX && passBottomX <= center.x + dist / 2 && between(start.x, end.x, passBottomX);
      }
      if (vertical) inBox = center.x - dist / 2 <= start.x && start.x <= center.x + dist / 2 && (between(start.y, end.y, center.y - wid / 2) || between(start.y, end.y, center.y + wid / 2));
      if (horizontal) inBox = center.y - wid / 2 <= start.y && start.y <= center.x + wid / 2 && (between(start.x, end.x, center.x - dist / 2) || between(start.x, end.x, center.x + dist / 2));
      if (inBox) {
        r.getNext().setPrev(null);
        map.addRope(new Rope(r.getNext(), this));
        endpointB = r;
        len = (i - 1) * len / (numNodes - 1);
        numNodes = i;
        r.setNext(null);
      } else cut(r.getNext(), startX, startY, endX, endY, i + 1);
    }
  }

  private PVectorD calcForce(RopeNode r) {
    PVectorD force = new PVectorD();
    if (r !=  null && r.getPrev() !=  null) {
      PVectorD direction = staticP.sub(r.getPrev().getPosition(), r.getPosition());
      double displacement = direction.mag() - len / (numNodes - 1);
      force = direction.normalize().mult(SPRING_STIFFNESS * numNodes * displacement);
    }
    return force;
  }

  public void move() {
    move(endpointA);
  }

  private void move(RopeNode r) {
    PVectorD springForce = calcForce(r);
    r.setSpringForce(springForce);
    PVectorD force = springForce;
    if (r !=  endpointB) {
      move(r.getNext());
      force = springForce.sub(r.getNext().getSpringForce());
    }
    Candy candy = r.getCandyLink();
    if (candy !=  null) candy.applyForce(force);
    force.add(staticP.mult(gravity, r.getMass()));
    if (endpointB.getCandyLink() !=  null && !endpointA.getMovable()) {
      boolean stationary = false;
      ArrayList <RopeNode> links = endpointB.getCandyLink().getLinks();
      for (int i = 0; i < links.size() && !stationary; i++) {
        if (links.get(i) !=  endpointB) {
          stationary = !links.get(i).getRope().getEndpointA().getMovable();
        }
      }
      if (stationary) force.add(staticP.mult(r.getVelocity(), (ENERGY_LOSS - 1) * r.getMass() / dt));
    }
    r.applyForce(force);
  }

  public void connect() {
  }

  public void disconnect() {
  }
}
