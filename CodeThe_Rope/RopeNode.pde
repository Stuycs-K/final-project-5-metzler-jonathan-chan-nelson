public class RopeNode{
  private RopeNode neighborA, neighborB;
  private PVector position, velocity, acceleration;
  private float mass;
  private float len;
  private boolean movable = true;
  
  public RopeNode(PVector p, PVector v, PVector a, float m, float l, boolean movable){
    neighborA = null;
    neighborB = null;
    position = p;
    velocity = v;
    acceleration = a;
    mass = m;
    movable = movable;
    len = l;
  }
  
  public RopeNode(PVector p, float m){
    this(p, new PVector(0,0), new PVector(0,0), m, 0, true);
  }
  
  public RopeNode(RopeNode r){
    this(r.getPosition(), r.getVelocity(), r.getAcceleration(), r.getMass(), r.getLength(), r.getMovable());
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
  
  public void setLength(float l){
    len = l;
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
  
  public float getLength(){
    return len;
  }
  
  public boolean getMovable(){
    return movable;
  }
  
  void applyForce(PVector f) {
    acceleration.set(0.0, 0.0);
    acceleration.add(PVector.div(f,mass));
    velocity.mult((float) SPRING_DAMPEN);
    velocity.add(acceleration);
    position.add(velocity);
  }
}
