public class Rope {
  private RopeNode endpointA, endpointB;
  float len, mass, energy;
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
    float A = calcA(P1, new PVector(p2X, P2.y));
    float a = (p2X - P1.x) / (2 * A);
    float b = (float) ((P1.x + p2X) / 2 - a * Math.log((1 + (P1.y - P2.y) / l) / (1 - (P1.y - P2.y) / l)) / 2);
    float c = (float) (-P1.y - a * Math.cosh((P1.x - b) / a));
    float dx = (p2X - P1.x) / (100 * n);
    int i = 1;
    RopeNode currNode = endpointA;
    for(float errorBound = 0; i != n; errorBound += 0.0001){
      i = 1;
      currNode = endpointA;
      for(int j = 1; j <= 100 * n && i < n; j++){
        PVector p = new PVector((float) (P1.x + j * dx), (float) - (a * Math.cosh((P1.x + j * dx - b) / a) + c));
        if(P2.x < P1.x) p = new PVector((float) (P1.x - j * dx), (float) - (a * Math.cosh((P1.x + j * dx - b) / a) + c));
        if(dx == 0) p = new PVector(P1.x, P1.y + i * (P2.y - P1.y) / (n - 1));
        if(Math.abs(PVector.sub(p, currNode.getPosition()).mag() - l / (n - 1)) < errorBound || dx == 0){
            p.add(new PVector(p.x, p.y).normalize().mult(errorBound));
            RopeNode node = new RopeNode(this, p, mass/ n);
            if(i == n - 1)node = endpointB;
            currNode.setNext(node);
            node.setPrev(currNode);
            node.setLength(node.getPrev().getLength() + PVector.dist(node.getPrev().getPosition(), node.getPosition()));
            currNode = node;
            i++;
          }
      }
    }
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
      RopeNode node = currNode.getNext();
      PVector currPos = currNode.getPosition();
      PVector pos = node.getPosition();
      float angle = PI + atan((currPos.y - pos.y)/(currPos.x - pos.x));
      float x = PVector.add(currPos, pos).x / 2;
      float y = PVector.add(currPos, pos).y /2;
      float l = PVector.dist(currPos, pos);
      fill(color(currPos.x, currPos.y, 0));
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
    if(endpointB.getMovable()){
      energy = 0;
      move(endpointA.getNext(), new PVector(0, 0));
    }
  }
  
  private PVector calcForce(RopeNode r) {
    PVector force = new PVector(0, 0);
    if (r != null) {
      PVector direction = PVector.sub(r.getPrev().getPosition(), r.getPosition());
      float displacement = direction.mag() - SPRING_LENGTH;
      force = direction.normalize().mult(SPRING_CONSTANT * displacement);
    }
    return force;
  }
  
  private void move(RopeNode r, PVector t){
      PVector springForce = calcForce(r);//.mult((float) Math.pow(1.01 , len * 3 / 4 - r.getLength()));
      if(r != endpointB) move(r.getNext(), PVector.mult(springForce, 1));
      
      energy += Math.pow(r.getVelocity().mag(), 2) + r.getPosition().y * r.getMass() * gravity.y;
      PVector force = springForce.sub(t).add(PVector.mult(gravity, r.getMass()));
      PVector direction = PVector.sub(new PVector(endpointA.getPosition().x, endpointA.getPosition().y + r.getLength()), r.getPosition());
      //float displacement = r.getLength() - direction.mag();
      //log((float) Math.sqrt(numNodes))
      float warp = 5 * (1 - r.getLength() / len);
      if(warp < 2) warp = 2;
      force.add(direction.normalize().mult(warp)); 
      r.applyForce(force);
      if (r.getLength() < PVector.dist(endpointA.getPosition(), r.getPosition())) {
        PVector oldDisplacement = PVector.sub(r.getPosition(), endpointA.getPosition());
        r.setPosition(PVector.add(endpointA.getPosition(), oldDisplacement.normalize().mult(r.getLength())));
      }
      energy += Math.pow(r.getVelocity().mag(), 2) + r.getPosition().y * r.getMass() * gravity.y;
      if(r == endpointB){
        print(r.getPosition() +"," +/* ": " + force + ", " +*/ r.getVelocity() + "\t");
      }
  }

  public void connect() {
  }

  public void disconnect() {
  }
}
