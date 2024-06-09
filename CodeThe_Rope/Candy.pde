public class Candy extends Node {
  private ArrayList <RopeNode> links = new ArrayList <RopeNode>();
  private PVectorD velocity;
  private double mass;

  public Candy(double x, double y, float xSpeed, float ySpeed, float mass_, float r) {
    super(x, y, createShape(ELLIPSE, 0, 0, r, r), r, color(255, 0, 0), loadImage("Candy.png"));
    velocity = new PVectorD(xSpeed, ySpeed);
    mass = mass_;
  }

  public void move() {
    applyForce(staticP.mult(gravity, mass));
    for (int i = 0; i < links.size(); i++) {
      links.get(i).setPosition(getPosition());
    }
  }

  private void applyForce(PVectorD f) {
    velocity.mult(ENERGY_LOSS);
    velocity.add(staticP.mult(f, dt / mass));
    getPosition().add(staticP.mult(velocity, dt));
  }

  public void link(RopeNode r) {
    if (links.size() == 0) velocity.div(2);
    links.add(r);
    r.setCandyLink(this);
  }

  public void unlink(RopeNode r) {
    if (links.indexOf(r) != -1) {
      r.setCandyLink(null);
      links.remove(r);
    }
    if (links.size() == 0) velocity.mult(2);
  }

  public ArrayList <RopeNode> getLinks() {
    return links;
  }
}
