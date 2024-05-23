public class RopeNode{
  private RopeNode neighborA, neighborB;
  private PVector position, velocity, acceleration, tension;
  private float mass;
  private boolean movable = true;
  
  public RopeNode(PVector p, float m){
    neighborA = null;
    neighborB = null;
    position = p;
    mass = m;
    velocity = new PVector(0.0, 0.0);
    acceleration = new PVector(0, 0);
    tension = new PVector(0, 0);
    movable = true;
  }
  
  public void setPrev(RopeNode a){
    neighborA = a;
  }
  
  public void setNext(RopeNode b){
    neighborB = b;
  }
  
  public void setMovable(boolean m){
    movable = m;
  }
  
  public RopeNode getPrev(){
    return neighborA;
  }
  
  public RopeNode getNext(){
    return neighborB;
  }
  
  public PVector getPosition(){
    return position;
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
