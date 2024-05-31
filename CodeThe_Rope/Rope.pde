public class Rope {
  private RopeNode endpointA, endpointB;
  float len, mass;
  int numNodes;
  color col;

   public Rope(PVector P1, PVector P2, float l, float m, int n){
    if(P2.x < P1.x){
      PVector temp = P1;
      P1 = P2;
      P2 = temp;
    }
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
      p = new PVector((float) (P1.x + i * dx), (float) - (a * Math.cosh((P1.x + i * dx - b) / a) + c));
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
  
  public void setColor(color c){
    col = c;
  }

  public void display() {
    noStroke();
    fill(col);
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
  }


  public void move() {
    move(endpointA.getNext());
  }
  
  public void move(RopeNode r) {
    if (endpointB.getMovable()) {
      float angle = atan((r.getPosition().y - endpointA.getPosition().y) / (r.getPosition().x - endpointA.getPosition().x));
      PVector potential = new PVector(endpointA.getPosition().x, endpointA.getPosition().y + r.getLength());
      //PVector potential = new PVector(r.getPrev().getPosition().x, r.getPrev().getPosition().y + r.getLength());
      PVector direction = PVector.sub(r.position, potential);
      //PVector tangent = new PVector(sin(angle), -cos(angle));
      //direction = tangent;
      direction.normalize();
      r.applyForce(direction.mult((float) (SPRING_CONSTANT * (1 / r.getLength() - PVector.dist(r.getPosition(), potential)))));
      //r.applyForce(gravity);
      print(r.getLength() + ", ");
      print(PVector.dist(endpointA.getPosition(), r.getPosition()));
      if (r.getLength() < PVector.dist(endpointA.getPosition(), r.getPosition())) {
        println();
        angle = atan((r.getPosition().y - endpointA.getPosition().y) / (r.getPosition().x - endpointA.getPosition().x));
        //r.applyForce(new PVector((float) 0.9 * -cos(angle) , (float) 0.9 * sin(angle)));
        if (r.getPosition().x > endpointA.getPosition().x) r.setPosition(new PVector(endpointA.getPosition().x + cos(angle) * r.getLength(), endpointA.getPosition().y + sin(angle) * r.getLength()));
        else if(r.getPosition().x > endpointA.getPosition().x) r.setPosition(new PVector(endpointA.getPosition().x - cos(angle) * r.getLength(), endpointA.getPosition().y - sin(angle) * r.getLength()));
        else r.setPosition(new PVector(endpointA.getPosition().x, endpointA.getPosition().x + r.getLength()));
      }
      if (r != endpointB) {
        move(r.getNext());
      }
    }
  }
/*
  public void move(RopeNode r) {
    if (endpointB.getMovable()) {
      PVector potential = new PVector(endpointA.getPosition().x, endpointA.getPosition().y + len);
      PVector direction = PVector.sub(r.position, potential);
      PVector v = r.getVelocity();
      direction.normalize();
      r.applyForce(direction.mult((float) (SPRING_CONSTANT * (1 / r.getLength() - PVector.dist(r.getPosition(), potential)))));
      r.applyForce(gravity);
      if (r.getLength() - r.getPrev().getLength() < PVector.dist(r.getPrev().getPosition(), r.getPosition())) {
        float angle = atan((r.getPosition().y - r.getPrev().getPosition().y) / (r.getPrev().getPosition().x - endpointA.getPosition().x));
        if (r.getPosition().x >= r.getPrev().getPosition().x) r.setPosition(new PVector(r.getPrev().getPosition().x + cos(angle) * (r.getLength() - r.getPrev().getLength()), r.getPrev().getPosition().y + sin(angle) * (r.getLength() - r.getPrev().getLength())));
        if (r.getPosition().x <= r.getPrev().getPosition().x) r.setPosition(new PVector(r.getPrev().getPosition().x - cos(angle) * (r.getLength() - r.getPrev().getLength()), r.getPrev().getPosition().y - sin(angle) * (r.getLength() - r.getPrev().getLength())));
        print(r.getPosition());
        //r.applyForce(new PVector((float) 0.9 * -cos(angle) , (float) 0.9 * sin(angle)));
        //if(r.getVelocity().x > 0) r.applyForce(new PVector((float) 2 * -cos(angle), (float) 2 * sin(angle)));
        //else r.applyForce(new PVector((float) 2 * sin(angle), (float) 2 * cos(angle)));
      }
      if (r != endpointB) {
        move(r.getNext());
      }
    }
  }
  */
  

  public void connect() {
  }

  public void disconnect() {
  }
}
