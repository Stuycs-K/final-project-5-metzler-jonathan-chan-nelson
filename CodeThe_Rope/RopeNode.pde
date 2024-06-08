public class RopeNode {
  private RopeNode neighborA, neighborB;
  private PVectorD position, velocity, acceleration, springForce;
  private Rope rope;
  private double mass;
  private boolean movable = true;

  public RopeNode(Rope r, PVectorD p, PVectorD v, PVectorD a, double ms, boolean m) {
    neighborA = null;
    neighborB = null;
    rope = r;
    position = p;
    velocity = v;
    acceleration = a;
    springForce = new PVectorD(0, 0);
    mass = ms;
    movable = m;
  }

  public RopeNode(Rope r, PVectorD p, double ms) {
    this(r, p, new PVectorD(0, 0), new PVectorD(0, 0), ms, true);
  }

  public RopeNode(RopeNode r) {
    this(r.getRope(), r.getPosition(), r.getVelocity(), r.getAcceleration(), r.getMass(), r.getMovable());
  }

  public void setPrev(RopeNode a) {
    neighborA = a;
  }

  public void setNext(RopeNode b) {
    neighborB = b;
  }

  public void setPosition(PVectorD p) {
    position = new PVectorD(p);
    ;
  }

  public void setVelocity(PVectorD v) {
    velocity = new PVectorD(v);
  }

  public void setSpringForce(PVectorD s) {
    springForce = new PVectorD(s);
    ;
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

  public Rope getRope() {
    return rope;
  }

  public PVectorD getPosition() {
    return position;
  }

  public PVectorD getVelocity() {
    return velocity;
  }

  public PVectorD getAcceleration() {
    return acceleration;
  }

  public PVectorD getSpringForce() {
    return springForce;
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
