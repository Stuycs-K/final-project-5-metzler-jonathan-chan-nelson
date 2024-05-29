public class RopeNode{
  private RopeNode neighborA, neighborB;
  private PVector position, velocity, acceleration, tension;
  private float mass;
  private boolean movable = true;
  private float energyLoss;
  
  public RopeNode(PVector p, PVector v, PVector a, PVector t, float m, boolean movable){
    neighborA = null;
    neighborB = null;
    position = p;
    velocity = v;
    acceleration = a;
    tension = t;
    mass = m;
    movable = movable;
    energyLoss = 1;
  }
  
  public RopeNode(PVector p, float m){
    this(p, new PVector(0,0), new PVector(0,0), new PVector(0,0), m, true);
  }
  
  public RopeNode(RopeNode r){
    this(r.getPosition(), r.getVelocity(), r.getAcceleration(), r.getTension(), r.getMass(), r.getMovable());
  }
  
  public void setPrev(RopeNode a){
    neighborA = a;
  }
  
  public void setNext(RopeNode b){
    neighborB = b;
  }
  
  public void setPosition(PVector p){
    position = p;
  }
  
  public void setVelocity(PVector v){
    velocity = v;
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
  
  public float getMass(){
    return mass;
  }
  
  public PVector getTension(){
    return tension;
  }
  
  public boolean getMovable(){
    return movable;
  }
  
  void applyForce(PVector f) {
    energyLoss *= SPRING_DAMPEN;
    acceleration.set(0.0, 0.0);
    acceleration.add(PVector.div(f,mass));
    velocity.add(acceleration);
    velocity.mult(energyLoss);
    position.add(velocity);
  }
}
