public class Candy extends node{
  PVector velocity, acceleration;
  float radius;
  float mass;
  color c;
  void move() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration=new PVector(0, 0);
    youLose();
  }

  void applyForce(PVector f) {
    acceleration.add(PVector.div(f,mass));
  }
  public Candy(float x, float y, float xSpeed, float ySpeed, float radius_, float mass_ ) {
    super(x,y,createShape(ELLIPSE, 0, 0, radius_, radius_));
    velocity = new PVector(xSpeed, ySpeed);
    acceleration = new PVector(0, 0);
    mass = mass_;
    radius = radius_;
    c = color(random(255), random(255), random(255));
  }
  
  public void youLose() {
    if (position.x < radius)
          text("You Lose", 500, 500);
    if (position.x > width-radius)
      text("You Lose", 500, 500);
    if (position.y < radius)
      text("You Lose", 500, 500);
    if (position.y > height-radius)
      text("You Lose", 500, 500);
  }
}
