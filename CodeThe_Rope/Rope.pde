public class Rope {
  private RopeNode endpointA, endpointB;
  double len, mass, energy;
  int numNodes;
  color col;

   public Rope(PVectorD P1, PVectorD P2, double l, double m, int n){
    double p2X = P2.x;
    if(p2X < P1.x) p2X = 2 * P1.x - P2.x;
    len = l;
    mass = m;
    numNodes = n;
    endpointA = new RopeNode(this, P1, mass / n);
    endpointB = new RopeNode(this, P2, mass / n);
    endpointA.setMovable(false);
    endpointB.setMovable(false);
    // Create Array
    double A = calcA(P1, new PVectorD(p2X, P2.y));
    double a = (p2X - P1.x) / (2 * A);
    double b =  ((P1.x + p2X) / 2 - a * Math.log((1 + (P1.y - P2.y) / l) / (1 - (P1.y - P2.y) / l)) / 2);
    double c =  (-P1.y - a * Math.cosh((P1.x - b) / a));
    double dx = (p2X - P1.x) / (100 * n);
    int i = 1;
    RopeNode currNode = endpointA;
    for(double errorBound = 0; i != n; errorBound += 0.0001){
      i = 1;
      currNode = endpointA;
      for(int j = 1; j <= 100 * n && i < n; j++){
        PVectorD p = new PVectorD( (P1.x + j * dx),  - (a * Math.cosh((P1.x + j * dx - b) / a) + c));
        if(P2.x < P1.x) p = new PVectorD( (P1.x - j * dx),  - (a * Math.cosh((P1.x + j * dx - b) / a) + c));
        if(dx == 0) p = new PVectorD(P1.x, P1.y + i * (P2.y - P1.y) / (n - 1));
        if(Math.abs(staticP.sub(p, currNode.getPosition()).mag() - l / (n - 1)) < errorBound || dx == 0 || n == n-1){
            p.add(new PVectorD(p.x, p.y).normalize().mult(errorBound));
            RopeNode node = new RopeNode(this, p, mass/ n);
            if(i == n - 1)node = endpointB;
            currNode.setNext(node);
            node.setPrev(currNode);
            node.setLength(node.getPrev().getLength() + staticP.dist(node.getPrev().getPosition(), node.getPosition()));
            currNode = node;
            i++;
          }
      }
    }
  }

  private double calcA(PVectorD P1, PVectorD P2) {
    double r = Math.sqrt(Math.pow(len, 2) - Math.pow(-P2.y + P1.y, 2)) / (P2.x - P1.x);
    double dA = 0.000001;
    double A = 0.0001;
    while (r * (A + dA) > Math.sinh(A + dA))A += dA;
    return A;
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

  public int getNum() {
    return numNodes;
  }

  public boolean hasTension() {
    return Math.abs(staticP.dist(endpointA.getPosition(), endpointB.getPosition()) - len) < 0.01;
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
      PVectorD currPos = currNode.getPosition();
      PVectorD pos = node.getPosition();
      float angle = PI + atan((float) ((currPos.y - pos.y)/(currPos.x - pos.x)));
      float x = (float) staticP.add(currPos, pos).x / 2;
      float y = (float) staticP.add(currPos, pos).y / 2;
      float l = (float) staticP.dist(currPos, pos);
      fill(color(255, 100, 200));
      translate(x, y);
      rotate(angle);
      rect(- l / 2, - w / 2, l, w);
      rotate(-angle);
      translate(-x, -y);
      currNode = node;
    }
  }


  private int signum(double f) {
    if (f < 0) return -1;
    return 1;
  }
  
   private PVectorD calcForce(RopeNode r) {
    PVectorD force = new PVectorD(0, 0);
    if (r != null && r.getPrev() != null) {
      PVectorD direction = staticP.sub(r.getPrev().getPosition(), r.getPosition());
      double displacement = direction.mag() - SPRING_LENGTH;
      force = direction.normalize().mult(SPRING_CONSTANT * displacement);
    }
    return force;
  }
 
  public void move() {
    if(endpointB.getMovable()){
      for(int i = 0; i < 20; i++){
        move(endpointA.getNext());
      }
    }
  }
  
  private void move(RopeNode r){
      PVectorD springForce = calcForce(r);
      r.setSpringForce(springForce);
      PVectorD force;
      if(r != endpointB) {
        move(r.getNext());
        force = springForce.sub(r.getNext().getSpringForce()).add(staticP.mult(gravity, r.getMass()));
      } 
      else force = springForce.add(staticP.mult(gravity, r.getMass()));
      r.applyForce(force);
  }

  public void connect() {
  }

  public void disconnect() {
  }
}
