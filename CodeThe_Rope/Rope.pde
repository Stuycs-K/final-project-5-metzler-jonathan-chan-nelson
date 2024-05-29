public class Rope{
  private RopeNode endpointA, endpointB, vertexNode;
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
    float[] constants = calcConst(P1, P2, A);
    float dx = (P2.x - P1.x) / n;
    for(int i = 1; i < n; i++){
      PVector p;
      RopeNode node;
      if(i < n - 1){
        if(dx == 0) p = new PVector(P1.x, i * l / n + P1.y);
        else p = new PVector((float) (P1.x + i * dx), (float) - (constants[0] * Math.cosh((P1.x + i * dx - constants[1]) / constants[0]) + constants[2]));
        node = new RopeNode(p, mass/ n);
      }
      else node = endpointB;
      currNode.setNext(node);
      if(i > 1 && currNode.getPrev().getPosition().y < currNode.getPosition().y && currNode.getNext().getPosition().y < currNode.getPosition().y) vertexNode = currNode;
      node.setPrev(currNode);
      currNode = node;
    }
    if(vertexNode == null){
      if(endpointB.getPosition().y <= endpointA.getPosition().y) vertexNode = endpointA;
      else vertexNode = endpointB;
    }
  }
  
  private float calcA(PVector P1, PVector P2){
    double r = Math.sqrt(Math.pow(len, 2) - Math.pow(-P2.y + P1.y, 2)) / (P2.x - P1.x);
    float dA = 0.000001;
    float A = 0.0001;
    while(r * (A + dA) > Math.sinh(A + dA))A += dA;
    return A;
  }
  
  private float[] calcConst(PVector P1, PVector P2, float A){
    float a = (P2.x - P1.x) / (2 * A);
    float b = (float) ((P1.x + P2.x) / 2 - a * Math.log((1 + (P1.y - P2.y) / len) / (1 - (P1.y - P2.y) / len)) / 2);
    float c = (float) (-P1.y - a * Math.cosh((P1.x - b) / a));
    return new float[]{a, b, c};
  }
  
  public RopeNode getEndpointA(){
    return endpointA;
  }
  
  public RopeNode getEndpointB(){
    return endpointB;
  }
  
  public float getLength(){
    return len;
  }
  
  public int getNum(){
    return numNodes;
  }
  
  public boolean hasTension(){
    return Math.abs(PVector.dist(endpointA.getPosition(), endpointB.getPosition()) - len) < 0.01;
  }
  
  public PVector getPosition(int i) throws Exception{
    if(i >= numNodes || i < 0) throw new Exception("IndexOutOfBounds: " + i);
    if(i < numNodes / 2) return getPosition(i, endpointA);
    else return getPosition(i, endpointB);
  }
  
  private PVector getPosition(int i, RopeNode r){
    if(i == 0 || i == numNodes - 1) return r.getPosition();
    if(i < numNodes / 2) return getPosition(i - 1, r.getNext());
    else return getPosition(i + 1, r.getPrev());
  }
  
  public void display(){
    noStroke();
    fill(color(255, 255, 255));
    RopeNode currNode = endpointA;
    float w = 5;
    for(int i = 0; i < numNodes - 1; i++){
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
    rect(vertexNode.getPosition().x - 2.5, vertexNode.getPosition().y - 2.5, 5, 5);
  }
  
  public Rope move(){
    RopeNode start = null, end = null;
    if(endpointA.getMovable() && !endpointB.getMovable()){
      start = endpointB;
      end = new RopeNode(endpointA);
    }
    if(endpointB.getMovable() && !endpointA.getMovable()){
      start = endpointA;
      end = new RopeNode(endpointB);
    }
    if(start != null && !hasTension()) {
      end.applyForce(gravity);
      float[] constants = calcConst(start.getPosition(), end.getPosition(), calcA(start.getPosition(), end.getPosition()));
      if(len > PVector.dist(start.getPosition(), new PVector(end.getPosition().x, (float) - (constants[0] * Math.cosh((end.getPosition().x - constants[1]) / constants[0]) + constants[2]))));
        return new Rope(endpointA.getPosition(), endpointB.getPosition(), len, mass, numNodes);
    }
    return this;
  }
  
  public void connect(){
  }
  
  public void disconnect(){
  }
}
