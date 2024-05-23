public class RopeNode{
  private RopeNode neighborA, neighborB;
  private PVector position, velocity, acceleration, tension;
  private float mass;
  private boolean movable = true;
  
  public RopeNode(RopeNode a, RopeNode b, PVector p, float m){
    if(a == null || b == null) movable = false;
    neighborA = a;
    neighborB = b;
    position = p;
    mass = m;
    velocity = new PVector(0.0, 0.0);
    acceleration = new PVector(0, 0);
    tension = new PVector(0, 0);
  }
  
  public RopeNode getNeighbor(int n){
    if(n % 2 == 0) return neighborA;
    return neighborB;
  }
  
  public PVector getVelocity(){
    return velocity;
  }
  
  public PVector getAcceleration(){
    return acceleration;
  }
  
  public PVector getTension(){
    return tension;
  }
}
