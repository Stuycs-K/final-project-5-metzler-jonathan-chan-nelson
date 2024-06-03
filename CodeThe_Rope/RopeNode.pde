public class RopeNode{
  private RopeNode neighborA, neighborB;
  private PVectorD position, velocity, acceleration, springForce;
  private Rope rope;
  private double mass;
  private double len;
  private boolean movable = true;
  
  public RopeNode(Rope r, PVectorD p, PVectorD v, PVectorD a, double m, double l, boolean movable){
    neighborA = null;
    neighborB = null;
    rope = r;
    position = p;
    velocity = v;
    acceleration = a;
    springForce = new PVectorD(0, 0);
    mass = m;
    movable = movable;
    len = l;
  }
  
  public RopeNode(Rope r, PVectorD p, double m){
    this(r, p, new PVectorD(0,0), new PVectorD(0,0), m, 0, true);
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
  
  public void setPosition(PVectorD p){
    position = new PVectorD(p);;
  }
  
  public void setVelocity(PVectorD v){
    velocity = new PVectorD(v);
  }
  
  public void setSpringForce(PVectorD s){
    springForce = new PVectorD(s);;
  }
  
  public void setLength(double l){
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
  
  public PVectorD getPosition(){
    return position;
  }
  
  public PVectorD getVelocity(){
    return velocity;
  }
  
  public PVectorD getAcceleration(){
    return acceleration;
  }
  
  public PVectorD getSpringForce(){
    return springForce;
  }
  
  public double getMass(){
    return mass;
  }
  
  public double getLength(){
    return len;
  }
  
  public boolean getMovable(){
    return movable;
  }
  
  public void applyForce(PVectorD f) {
    if(movable){
      double dt = 0.01;
      //velocity.mult(ENERGY_LOSS);
      velocity.add(staticP.mult(f, dt / mass));
      position.add(staticP.mult(velocity, dt));
    }
  }
}
