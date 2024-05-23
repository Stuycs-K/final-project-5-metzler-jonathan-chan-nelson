public class Rope{
  private RopeNode endpointA, endpointB;
  float len, mass;
  int numNodes;
  
  public Rope(PVector a, PVector b, float l, float m, int n){
    len = l;
    mass = m;
    numNodes = n;
    endpointA = new RopeNode(a, mass/ n);
    endpointB = new RopeNode(b, mass/ n);
    endpointA.setMovable(false);
    endpointB.setMovable(false);
    // Create Array
    RopeNode currNode = endpointA;
    for(int i = 1; i < n - 1; i++){
      PVector p = new PVector(0, i);
      RopeNode node = new RopeNode(p, mass/ n);
      currNode.setNext(node);
      node.setPrev(currNode);
      currNode = node;
    }
    currNode.setNext(endpointB);
    endpointB.setPrev(currNode);
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
  
  
  public void connect(){
  }
  
  public void disconnect(){
  }
}
