public class Rope{
  private RopeNode endpointA, endpointB;
  float len, mass;
  int numNodes;
  
  public Rope(PVector P1, PVector P2, float l, float m, int n) throws Exception{
    if(l < PVector.dist(P1, P2)) throw new Exception("Invalid length: Too short");
    len = l;
    mass = m;
    numNodes = n;
    endpointA = new RopeNode(P1, mass/ n);
    endpointB = new RopeNode(P2, mass/ n);
    endpointA.setMovable(false);
    endpointB.setMovable(false);
    // Create Array
    RopeNode currNode = endpointA;
    float A = calcA(P1, P2, l);
    float a = (P2.x - P1.x) / (2 * A);
    float b = (float) ((P1.x + P2.x) / 2 - a * Math.log((1 + (P1.y - P2.y) / l) / (1 - (P1.y - P2.y) / l)) / 2);
    float c = (float) (-P1.y - a * Math.cosh((P1.x - b) / a));
    float dx = (P2.x - P1.x) / n;
    for(int i = 1; i < n - 1; i++){
      PVector p;
      //print((float) (a * Math.cosh((P1.x + i * dx - b) / a) + c));
      if(dx == 0) p = new PVector(P1.x, i * l / n + P1.y);
      else p = new PVector((float) (P1.x + i * dx), (float) - (a * Math.cosh((P1.x + i * dx - b) / a) + c));
      println(p);
      //println(p);
      RopeNode node = new RopeNode(p, mass/ n);
      currNode.setNext(node);
      node.setPrev(currNode);
      currNode = node;
    }
    print(A);
    currNode.setNext(endpointB);
    endpointB.setPrev(currNode);
  }
  
  private float calcA(PVector P1, PVector P2, float l){
    double r = Math.sqrt(Math.pow(l, 2) - Math.pow(-P2.y + P1.y, 2)) / (P2.x - P1.x);
    float dA = 0.000001;
    float A = 0.0001;
    while(r * (A + dA) > Math.sinh(A + dA))A += dA;
    return A;
  }
  
  public float getLength(){
    return len;
  }
  
  public int getNum(){
    return numNodes;
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
  }
  
  public void connect(){
  }
  
  public void disconnect(){
  }
}
