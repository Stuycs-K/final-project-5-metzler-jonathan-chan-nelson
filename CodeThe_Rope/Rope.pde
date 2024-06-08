public class Rope {
  private RopeNode endpointA, endpointB;
  double len, wid;
  int numNodes;
  color col;
  Map map;
  
  private int signum(double d){
    if(d > 0) return 1;
    if(d < 0) return -1;
    return 0;
  }
  
  public Rope(Map m, PVectorD P1, PVectorD P2, double lFactor, double ms, int n) {
    map = m;
    len = lFactor * staticP.dist(P1, P2);
    wid = 5;
    numNodes = n;
    endpointA = new RopeNode(this, P1, ms);
    endpointB = new RopeNode(this, P2, ms);
    endpointA.setMovable(false);
    // Create Array
    double A = calcA(P1, new PVectorD(P2.x, P2.y));
    double a = (P2.x - P1.x) / (2 * A);
    double b =  ((P1.x + P2.x) / 2 - a * Math.log((1 + (P1.y - P2.y) / len) / (1 - (P1.y - P2.y) / len)) / 2);
    double c =  (-P1.y - a * Math.cosh((P1.x - b) / a));
    for (double errorBound = 0; endpointB.getPrev() == null; errorBound += 0.001) {
      int i = 1;
      RopeNode r = endpointA;
      for(double dx = 0; Math.abs(dx) < Math.abs(P2.x - P1.x); dx += (P2.x - P1.x) / (10000 - numNodes)) {
        PVectorD p = new PVectorD(P1.x + dx, -(a * Math.cosh((P1.x + Math.abs(dx) - b) / a) + c));
        if (Math.abs(staticP.sub(p, r.getPosition()).mag() - len / (n - 1)) < errorBound || i == n - 1) {
          p.add(new PVectorD(p.x, p.y).normalize().mult(errorBound));
          RopeNode next = new RopeNode(this, p, ms);
          if (i == n - 1) next = endpointB;
          r.setNext(next);
          next.setPrev(r);
          r = next;
          i++;
        }
      }
    }
  }

  private Rope(RopeNode r, Rope rope) {
    numNodes = 0;
    endpointA = rope.getEndpointB();
    reverse(endpointA);
    endpointB = r;
    wid = rope.getWidth();
    len = (getIndex(r) - 1) * rope.getLength() / (rope.getNumNodes() - 1);
    print(len);
    col = rope.getColor();
    map = rope.getMap();
  }

  private double calcA(PVectorD P1, PVectorD P2) {
    double r = Math.sqrt(Math.pow(len, 2) - Math.pow(-P2.y + P1.y, 2)) / (P2.x - P1.x);
    double dA = 0.000001;
    double A = 0.0001;
    while (r * (A + dA) > Math.sinh(A + dA))A += dA;
    return A;
  }

  private void reverse(RopeNode r) {
    if (r != null) {
      RopeNode prev = r.getPrev();
      r.setPrev(r.getNext());
      reverse(prev);
      r.setNext(prev);
      numNodes++;
    }
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

  public Map getMap() {
    return map;
  }

  public RopeNode getNode(int i) {
    if (i < numNodes / 2) return getNode(i, endpointA);
    else return getNode(i, endpointB);
  }
  
  public int getIndex(RopeNode r){
    if(r == endpointA) return 1;
    return 1 + getIndex(r.getPrev());
  }

  private RopeNode getNode(int i, RopeNode r) {
    if (i == 0 || i == numNodes - 1) return r;
    if (i < numNodes / 2) return getNode(i - 1, r.getNext());
    else return getNode(i + 1, r.getPrev());
  }

  public void setEndpointA(RopeNode r) {
    endpointA = r;
  }

  public void setEndpointB(RopeNode r) {
    endpointB = r;
  }

  public void setWidth(double w) {
    wid = w;
  }

  public void setColor(color c) {
    col = c;
  }

  public void display() {
    //For Demo
    if (stroke) stroke(0);
    else noStroke();
    fill(col);
    display(endpointA);
  }

  private void display(RopeNode r) {
    if (r != null && r.getNext() != null) {
      PVectorD rPos = r.getPosition();
      PVectorD nextPos = r.getNext().getPosition();
      float angle = -atan((float) ((nextPos.y - rPos.y)/(rPos.x - nextPos.x)));
      float x = (float) staticP.add(rPos, nextPos).x / 2;
      float y = (float) staticP.add(rPos, nextPos).y / 2;
      float l = (float) staticP.dist(rPos, nextPos);
      translate(x, y);
      rotate(angle);
      rect(- l / 2, - (float) wid / 2, l, (float) wid);
      rotate(-angle);
      translate(-x, -y);
      if (r != endpointB.getPrev()) display(r.getNext());
    }
  }

  public void cut(float startX, float startY, float endX, float endY) {
    cut(endpointA, startX, startY, endX, endY, 1);
  }

  private boolean between(double v1, double v2, double v3) {
    return v1 <= v3 && v3 <= v2 || v2 <= v3 && v3 <= v1;
  }

  private void cut(RopeNode r, float startX, float startY, float endX, float endY, int i) {
    if (r != endpointB) {
      PVector start = new PVector(startX, startY);
      PVector end = new PVector(endX, endY);
      PVector rPos = r.getPosition().toPVector();
      PVector nextPos = r.getNext().getPosition().toPVector();
      PVector center = PVector.add(rPos, nextPos).div(2);
      float angle = atan((float) ((nextPos.y - rPos.y)/(rPos.x - nextPos.x)));
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
        len = (getIndex(r) - 1) * len / (numNodes - 1);
        numNodes = i;
        r.setNext(null);
      } else cut(r.getNext(), startX, startY, endX, endY, i + 1);
    }
  }

  private PVectorD calcForce(RopeNode r) {
    PVectorD force = new PVectorD(0, 0);
    if (r != null && r.getPrev() != null) {
      PVectorD direction = staticP.sub(r.getPrev().getPosition(), r.getPosition());
      double displacement = direction.mag() - len / (numNodes - 1);
      force = direction.normalize().mult(SPRING_STIFFNESS * Math.pow(numNodes, 2) * displacement);
    }
    return force;
  }

  public void move() {
    for (int i = 0; i < 20; i++) {
      move(endpointA);
    }
  }

  private void move(RopeNode r) {
    PVectorD springForce = calcForce(r);
    r.setSpringForce(springForce);
    PVectorD force;
    if (r != endpointB) {
      move(r.getNext());
      force = springForce.sub(r.getNext().getSpringForce()).add(staticP.mult(gravity, r.getMass()));
    } else force = springForce.add(staticP.mult(gravity, r.getMass()));
    if (!endpointB.getMovable() && !endpointA.getMovable()) force.add(staticP.mult(r.getVelocity(), -0.999));
    r.applyForce(force);
  }

  public void connect() {
  }

  public void disconnect() {
  }
}
