public class Rope {
  private RopeNode endpointA, endpointB;
  float len, mass;
  int numNodes;
  color col;

   public Rope(PVector P1, PVector P2, float l, float m, int n){
    float p2X = P2.x;
    if(p2X < P1.x) p2X = 2 * P1.x - P2.x;
    len = l;
    mass = m;
    numNodes = n;
    endpointA = new RopeNode(this, P1, mass / n);
    endpointB = new RopeNode(this, P2, mass / n);
    endpointA.setMovable(false);
    endpointB.setMovable(false);
    // Create Array
    RopeNode currNode = endpointA;
    float A = calcA(P1, new PVector(p2X, P2.y));
    float a = (p2X - P1.x) / (2 * A);
    float b = (float) ((P1.x + p2X) / 2 - a * Math.log((1 + (P1.y - P2.y) / l) / (1 - (P1.y - P2.y) / l)) / 2);
    float c = (float) (-P1.y - a * Math.cosh((P1.x - b) / a));
    float dx = (p2X - P1.x) / (100 * n);
    int i = 1;
    float errorBound = 0.2;
    for(int j = 1; j <= 100 * n && i < n - 1; j++){
      PVector p = new PVector((float) (P1.x + j * dx), (float) - (a * Math.cosh((P1.x + j * dx - b) / a) + c));
      if(P2.x < P1.x) p = new PVector((float) -(P1.x + j * dx), (float) - (a * Math.cosh((P1.x + j * dx - b) / a) + c));
      if(Math.abs(PVector.sub(p, currNode.getPosition()).mag() - l / (n - 1)) < 0.2){
          println("p");
          p.add(new PVector(p.x, p.y).normalize().mult(0.2));
          RopeNode node = new RopeNode(this, p, mass/ n);
          currNode.setNext(node);
          node.setPrev(currNode);
          node.setLength(node.getPrev().getLength() + PVector.dist(node.getPrev().getPosition(), node.getPosition()));
          currNode = node;
          i++;
        }
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
    //noStroke();
    fill(col);
    RopeNode currNode = endpointA;
    float w = 5;
    for (int i = 0; i < numNodes - 1; i++) {
      fill(color(random(255), random(255), random(255)));
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


  private int signum(float f) {
    if (f < 0) return -1;
    return 1;
  }
 
  public void move() {
    move(endpointA.getNext());
  }
  
  private PVector calcForce(RopeNode r){
    PVector rPos = r.getPosition();
    PVector prevPos = r.getPrev().getPosition();
    PVector direction = PVector.sub(rPos, prevPos);
    float displacement = SPRING_LENGTH - direction.mag();
    PVector force = direction.normalize().mult(SPRING_STIFFNESS * displacement).add(gravity);
    if(r == endpointB) return force;
    return force.sub(calcForce(r.getNext()));
  }
  
  private void move(RopeNode r){
    if(endpointB.getMovable()){
      PVector force = calcForce(r);
      if(r != endpointB) move(r.getNext());
      else println();
      r.applyForce(force);
      println(force);
    }
  }

  public void connect() {
  }

  public void disconnect() {
  }
}
