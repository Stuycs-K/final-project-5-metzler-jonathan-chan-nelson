public class Rope {
  private RopeNode endpointA, endpointB;
  double len, wid;
  int numNodes;
  color col;
  Map map;

  public Rope(Map m, PVectorD P1, PVectorD P2, double lFactor, double ms, int n) {
    map = m;
    double p2X = P2.x;
    if (p2X < P1.x) p2X = 2 * P1.x - P2.x;
    len = lFactor * staticP.dist(P1, P2);
    wid = 5;
    numNodes = n;
    endpointA = new RopeNode(this, P1, ms);
    endpointB = new RopeNode(this, P2, ms);
    endpointA.setMovable(false);
    endpointB.setMovable(false);
    // Create Array
    double A = calcA(P1, new PVectorD(p2X, P2.y));
    double a = (p2X - P1.x) / (2 * A);
    double b =  ((P1.x + p2X) / 2 - a * Math.log((1 + (P1.y - P2.y) / len) / (1 - (P1.y - P2.y) / len)) / 2);
    double c =  (-P1.y - a * Math.cosh((P1.x - b) / a));
    double dx = (p2X - P1.x) / (10000 * n);
    int i = 1;
    RopeNode currNode = endpointA;
    for (double errorBound = 0; i != n; errorBound += 0.001) {
      i = 1;
      currNode = endpointA;
      for (int j = 1; j <= 10000 * n && i < n; j++) {
        PVectorD p = new PVectorD( (P1.x + j * dx), - (a * Math.cosh((P1.x + j * dx - b) / a) + c));
        if (P2.x < P1.x) p = new PVectorD( (P1.x - j * dx), - (a * Math.cosh((P1.x + j * dx - b) / a) + c));
        if (dx == 0) p = new PVectorD(P1.x, P1.y + i * (P2.y - P1.y) / (n - 1));
        if (Math.abs(staticP.sub(p, currNode.getPosition()).mag() - len / (n - 1)) < errorBound || dx == 0 || i == n - 1) {
          p.add(new PVectorD(p.x, p.y).normalize().mult(errorBound));
          RopeNode node = new RopeNode(this, p, ms);
          if (i == n - 1) node = endpointB;
          currNode.setNext(node);
          node.setPrev(currNode);
          node.setLength(node.getPrev().getLength() + staticP.dist(node.getPrev().getPosition(), node.getPosition()));
          currNode = node;
          i++;
        }
      }
    }
  }

  private Rope(RopeNode rB, Rope r) {
    numNodes = 0;
    endpointA = r.getEndpointB();
    reverse(endpointA, endpointA.getLength());
    endpointB = rB;
    wid = r.getWidth();
    len = rB.getLength();
    col = r.getColor();
    map = r.getMap();
  }

  private double calcA(PVectorD P1, PVectorD P2) {
    double r = Math.sqrt(Math.pow(len, 2) - Math.pow(-P2.y + P1.y, 2)) / (P2.x - P1.x);
    double dA = 0.000001;
    double A = 0.0001;
    while (r * (A + dA) > Math.sinh(A + dA))A += dA;
    return A;
  }

  private void reverse(RopeNode r, double endLength) {
    if (r != null) {
      r.setLength(endLength - r.getLength());
      RopeNode prev = r.getPrev();
      r.setPrev(r.getNext());
      reverse(prev, endLength);
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
    RopeNode currNode = endpointA;
    for (int i = 0; i < numNodes - 1; i++) {
      RopeNode node = currNode.getNext();
      PVectorD currPos = currNode.getPosition();
      PVectorD pos = node.getPosition();
      float angle = PI + atan((float) ((currPos.y - pos.y)/(currPos.x - pos.x)));
      float x = (float) staticP.add(currPos, pos).x / 2;
      float y = (float) staticP.add(currPos, pos).y / 2;
      float l = (float) staticP.dist(currPos, pos);
      fill(color(255, 100, 200));
      translate(x, y);
      rotate(angle);
      rect(- l / 2, - (float) wid / 2, l, (float) wid);
      rotate(-angle);
      translate(-x, -y);
      currNode = node;
    }
  }

  public void cut(float startX, float startY, float endX, float endY) {
    cut(endpointA, startX, startY, endX, endY, 1);
  }

  private void cut(RopeNode r, float startX, float startY, float endX, float endY, int i) {
    if (r != endpointB) {
      PVector start = new PVector(startX, startY);
      PVector end = new PVector(endX, endY);
      PVector rPos = r.getPosition().toPVector();
      PVector nextPos = r.getNext().getPosition().toPVector();
      PVector center = PVector.add(rPos, nextPos).div(2);
      float angle = PI + atan((float) ((rPos.y - nextPos.y)/(rPos.x - nextPos.x)));
      float dist = PVector.dist(rPos, nextPos);
      start.sub(center);
      end.sub(center);
      start.set(new PVector(-start.x * sin(-angle) + start.y * cos(-angle), -start.x * cos(-angle) - start.y * sin(-angle)));
      end.set(new PVector(-end.x * sin(-angle) + end.y * cos(-angle), -end.x * cos(-angle) - end.y * sin(-angle)));
      start.add(center);
      end.add(center);
      boolean passLeft = start.x < center.x - wid / 2 && end.x > center.x - wid / 2 || start.x > center.x - wid / 2 && end.x < center.x - wid / 2;
      boolean passRight = start.x < center.x + wid / 2 && end.x > center.x + wid / 2 || start.x > center.x + wid / 2 && end.x < center.x + wid / 2;
      boolean passTop = start.y < center.y + dist / 2 && end.y > rPos.x + dist / 2 || start.y > rPos.y + dist / 2 && end.y < rPos.y + dist / 2;
      boolean passBottom = start.y < center.y - dist / 2 && end.y > rPos.x - dist / 2 || start.y > rPos.y - dist / 2 && end.y < rPos.y - dist / 2;
      if (passLeft && passTop || passLeft && passBottom || passRight && passTop || passRight && passBottom) {
        r.getNext().setPrev(null);
        map.addRope(new Rope(r.getNext(), this));
        endpointB = r;
        len = endpointB.getLength();
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
      force = direction.normalize().mult(SPRING_STIFFNESS * numNodes * displacement);
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
    try {
      r.setSpringForce(springForce);
      PVectorD force;
      if (r != endpointB) {
        move(r.getNext());
        force = springForce.sub(r.getNext().getSpringForce()).add(staticP.mult(gravity, r.getMass()));
      } else force = springForce.add(staticP.mult(gravity, r.getMass()));
      if (!endpointB.getMovable() && !endpointA.getMovable()) force.add(staticP.mult(r.getVelocity(), -0.999));
      r.applyForce(force);
    }
    catch(NullPointerException e) {
    }
  }

  public void connect() {
  }

  public void disconnect() {
  }
}
