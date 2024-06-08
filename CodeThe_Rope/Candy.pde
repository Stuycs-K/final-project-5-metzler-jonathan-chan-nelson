public class Candy extends node {
  PVectorD velocity, acceleration;
  float radius;
  float mass;
  color c;
  PImage img;
  //ArrayList<RopeNode> links = new ArrayList<RopeNode>();

  void display() {
    imageMode(CENTER);
    image(img, (float) position.x, (float) position.y, radius + 10, radius + 10);
  }
  
  public void applyForce(PVectorD f) {
    velocity.mult(ENERGY_LOSS);
    velocity.add(staticP.mult(f, dt / mass));
    position.add(staticP.mult(velocity, dt));
  }

  public Candy(float x, float y, float xSpeed, float ySpeed, float mass_, float radius_ ) {
    super(x, y, createShape(ELLIPSE, 0, 0, radius_, radius_), color(255, 0, 0));
    velocity = new PVectorD(xSpeed, ySpeed);
    acceleration = new PVectorD(0, 0);
    mass = mass_;
    radius = radius_;
    img = loadImage("Candy.jpg");
  }

  public boolean offTheMap() {
    if (position.x < radius) {
      return true;
    }
    if (position.x > width-radius) {
      return true;
    }
    if (position.y < radius) {
      return true;
    }
    if (position.y > height-radius) {
      return true;
    }
    return false;
  }
  
  /*

  public void link(RopeNode r) {
    links.add(r);
  }

  public void unlink(RopeNode r) {
    if (links.indexOf(r) != -1) {
      if (links.size() == 1) velocity = staticP.mult(r.getVelocity(), mass / (r.getMass() + mass));
      links.remove(r);
    }
  }
  */
}
