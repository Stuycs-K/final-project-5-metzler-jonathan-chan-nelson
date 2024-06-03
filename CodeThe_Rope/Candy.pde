public class Candy extends node {
  PVectorD velocity, acceleration;
  float radius;
  float mass;
  color c;
  PImage img;
  RopeNode link;

  void display() {
    imageMode(CENTER);
    if(link != null){
      position.x = link.getPosition().x;
      position.y = link.getPosition().y;
    }
    image(img, (float) position.x, (float) position.y, radius + 10, radius + 10);
  }
  
  
  void applyForce(PVectorD f) {
    if(link == null){
      double dt = 0.01;
      velocity.add(staticP.mult(f, dt / mass));
      position.add(staticP.mult(velocity, dt));
    }
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
  
  public void link(RopeNode r){
    if(link == null){
      link = r;
      r.setMass(r.getMass() + mass);
    }
  }
  
  public void unlink(){
    if(link != null){
      link.setMass(link.getMass() - mass);
      link = null;
    }
  }
  
  public RopeNode getLink(){
    return link;
  }
}
