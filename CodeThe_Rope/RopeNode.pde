public class RopeNode {
  private RopeNode neighborA;
  private RopeNode neighborB;
  private PVectorD position;
  private PVectorD velocity = new PVectorD();
  private PVectorD springForce = new PVectorD();
  private Candy candyLink;
  private Rope rope;
  private double mass;
  private boolean movable = true;
  ;

  public RopeNode(Rope r, PVectorD p, double ms) {
    rope = r;
    position = p;
    springForce = new PVectorD();
    mass = ms;
  }


  public RopeNode(RopeNode r) {
    this(r.getRope(), r.getPosition(), r.getMass());
    velocity = r.getVelocity();
    movable =  r.getMovable();
    springForce = r.getSpringForce();
  }

  public void setPrev(RopeNode a) {
    neighborA = a;
  }

  public void setNext(RopeNode b) {
    neighborB = b;
  }

  public void setPosition(PVectorD p) {
    position = new PVectorD(p);
  }

  public void setVelocity(PVectorD v) {
    velocity = new PVectorD(v);
  }

  public void setSpringForce(PVectorD s) {
    springForce = new PVectorD(s);
  }

  public void setCandyLink(Candy c) {
    candyLink = c;
  }

  public void setMass(double m) {
    mass = m;
  }

  public void setMovable(boolean m) {
    movable = m;
  }

  public RopeNode getPrev() {
    return neighborA;
  }

  public RopeNode getNext() {
    return neighborB;
  }

  public PVectorD getPosition() {
    return position;
  }

  public PVectorD getVelocity() {
    return velocity;
  }

  public PVectorD getSpringForce() {
    return springForce;
  }


  public Rope getRope() {
    return rope;
  }

  public Candy getCandyLink() {
    return candyLink;
  }

  public double getMass() {
    return mass;
  }

  public boolean getMovable() {
    return movable;
  }

  public void applyForce(PVectorD f) {
    if (movable) {
      velocity.mult(ENERGY_LOSS);
      velocity.add(staticP.mult(f, dt / mass));
      position.add(staticP.mult(velocity, dt));
    }
  }
}
