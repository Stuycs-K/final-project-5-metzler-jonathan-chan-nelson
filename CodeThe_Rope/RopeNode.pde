public class RopeNode{
  private RopeNode neighborA, neighborB;
  private PVector position, velocity, acceleration, force;
  private Rope rope;
  private float mass;
  private float len;
  private boolean movable = true;
  
  public RopeNode(Rope r, PVector p, PVector v, PVector a, float m, float l, boolean movable){
    neighborA = null;
    neighborB = null;
    rope = r;
    position = p;
    velocity = v;
    acceleration = a;
    force = new PVector(0, 0);
    mass = m;
    movable = movable;
    len = l;
  }
  
  public RopeNode(Rope r, PVector p, float m){
    this(r, p, new PVector(0,0), new PVector(0,0), m, 0, true);
  }
  
  public RopeNode(RopeNode r){
    this(r.getRope(), r.getPosition(), r.getVelocity(), r.getAcceleration(), r.getMass(), r.getLength(), r.getMovable());
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
  
  public Rope getRope(){
    return r;
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
  
  public PVector getForce(){
    return force;
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
    velocity.add(PVector.div(f, mass));
    position.add(velocity);
  }
}
