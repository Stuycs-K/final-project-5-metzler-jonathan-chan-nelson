public class Candy extends node {
  PVectorD velocity, acceleration;
  float radius;
  float mass;
  color c;
  PImage img;
  ArrayList<RopeNode> links = new ArrayList<RopeNode> (5);

  void display() {
    imageMode(CENTER);
    image(img, (float) position.x, (float) position.y, radius + 10, radius + 10);
  }
  
  void move(){
    position = new PVectorD(0, 0);
    for(RopeNode r : links){
      position.add(staticP.div(r.getPosition(), links.size()));
    }
    for(RopeNode r : links){
      r.setPosition(position);
    }
  }
  
  void applyForce(PVectorD f) {
    if(links.size() > 0){
      double dt = 0.01;
      velocity.add(staticP.mult(f, dt / mass));
      position.add(staticP.mult(velocity, dt));
    }
  }
  
  public Candy(double x, double y, float xSpeed, float ySpeed, float mass_, float radius_ ) {
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
    links.add(r);
    r.setMass(r.getMass() + mass);
  }
  
  public void unlink(){
    for(int i = 0; i < links.size(); i++) links.get(i).setMovable(false);
  }
  
  public RopeNode getLink(int n){
    return links.get(n);
  }
}
