public class Rope {
  private RopeNode endpointA, endpointB;
  float len, mass;
  int numNodes;

   public Rope(PVector P1, PVector P2, float l, float m, int n){
    len = l;
    mass = m;
    numNodes = n;
    endpointA = new RopeNode(P1, mass/ n);
    endpointB = new RopeNode(P2, mass/ n);
    endpointA.setMovable(false);
    endpointB.setMovable(false);
    // Create Array
    RopeNode currNode = endpointA;
    float A = calcA(P1, P2);
    float a = (P2.x - P1.x) / (2 * A);
    float b = (float) ((P1.x + P2.x) / 2 - a * Math.log((1 + (P1.y - P2.y) / l) / (1 - (P1.y - P2.y) / l)) / 2);
    float c = (float) (-P1.y - a * Math.cosh((P1.x - b) / a));
    float dx = (P2.x - P1.x) / n;
    for(int i = 1; i < n; i++){
      PVector p;
      if(dx == 0) p = new PVector(P1.x, i * l / n + P1.y);
      else p = new PVector((float) (P1.x + i * dx), (float) - (a * Math.cosh((P1.x + i * dx - b) / a) + c));
      RopeNode node = new RopeNode(p, mass/ n);
      if(i < n - 1){
        if(dx == 0) p = new PVector(P1.x, i * l / n + P1.y);
        else p = new PVector((float) (P1.x + i * dx), (float) - (a * Math.cosh((P1.x + i * dx - b) / a) + c));
        node = new RopeNode(p, mass/ n);
      }
      else node = endpointB;
      currNode.setNext(node);
      node.setPrev(currNode);
      node.setLength(node.getPrev().getLength() + PVector.dist(node.getPrev().getPosition(), node.getPosition()));
      currNode = node;
    }
    currNode.setNext(endpointB);
    endpointB.setPrev(currNode);
  }

  private float calcA(PVector P1, PVector P2) {
    double r = Math.sqrt(Math.pow(len, 2) - Math.pow(-P2.y + P1.y, 2)) / (P2.x - P1.x);
    float dA = 0.000001;
    float A = 0.0001;
    while (r * (A + dA) > Math.sinh(A + dA))A += dA;
    return A;
  }

  public RopeNode getEndpointA() {
    return endpointA;
  }

  public RopeNode getEndpointB() {
    return endpointB;
  }

  public float getLength() {
    return len;
  }

  public int getNum() {
    return numNodes;
  }

  public boolean hasTension() {
    return Math.abs(PVector.dist(endpointA.getPosition(), endpointB.getPosition()) - len) < 0.01;
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

  public void display() {
    noStroke();
    fill(color(255, 255, 255));
    RopeNode currNode = endpointA;
    float w = 5;
    for (int i = 0; i < numNodes - 1; i++) {
      RopeNode node = currNode.getNext();
      PVector currPos = currNode.getPosition();
      PVector pos = node.getPosition();
      float angle = PI + atan((currPos.y - pos.y)/(currPos.x - pos.x));
      float x = PVector.add(currPos, pos).x / 2;
      float y = PVector.add(currPos, pos).y /2;
      float l = PVector.dist(currPos, pos);
      translate(x, y);
      rotate(angle);
      rect(- l / 2, - w / 2, l, w);
      rotate(-angle);
      translate(-x, -y);
      currNode = node;
    }
    fill(color(0, 0, 0));
  }


  public void move() {
    move(endpointA.getNext());
  }

  public void move(RopeNode r) {
    if (endpointB.getMovable()) {
      PVector potential = new PVector(endpointA.getPosition().x, endpointA.getPosition().y + len);
      PVector direction = PVector.sub(r.position, potential);
      direction.normalize();
      r.applyForce(direction.mult((float) (SPRING_CONSTANT * (1 / r.getLength() - PVector.dist(r.getPosition(), potential)))));
      r.applyForce(gravity);
      if (r.getLength() < PVector.dist(endpointA.getPosition(), r.getPosition())) {
        print("\t");
        float angle = atan((r.getPosition().x - endpointA.getPosition().x)/(r.getPosition().y - endpointA.getPosition().y));
        r.setPosition(new PVector(endpointA.getPosition().x + sin(angle) * r.getLength(), endpointA.getPosition().y + cos(angle) * r.getLength()));
        //r.getPosition().normalize().mult(len);
      }
      if (r != endpointB) {
        move(r.getNext());
      }
    }
  }

  public void connect() {
  }

  public void disconnect() {
  }
}
