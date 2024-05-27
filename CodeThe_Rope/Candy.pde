public class Candy extends node{
  PVector velocity, acceleration;
  float radius;
  float mass;
  color c;
  void move(goal other) {
    if(youWin(other)){}
    if(youLose()){}
    else{
      velocity.add(acceleration);
      position.add(velocity);
      acceleration=new PVector(0, 0);
    }
  }

  void applyForce(PVector f) {
    acceleration.add(PVector.div(f,mass));
  }
  public Candy(float x, float y, float xSpeed, float ySpeed, float radius_, float mass_ ) {
    super(x,y,createShape(ELLIPSE, 0, 0, radius_, radius_),color(255,0,0));
    velocity = new PVector(xSpeed, ySpeed);
    acceleration = new PVector(0, 0);
    mass = mass_;
    radius = radius_;
    c = color(random(255), random(255), random(255));
  }
  
  public boolean youLose() {
    if (position.x < radius){
      text("You Lose", 500, 500);
      return true;
    }
    if (position.x > width-radius){
      text("You Lose", 500, 500);
      return true;
    }
    if (position.y < radius){
      text("You Lose", 500, 500);
      return true;
    }
    if (position.y > height-radius){
      text("You Lose", 500, 500);
      return true;
    }
      return false;
  }
  
  public boolean youWin(goal other) {
    if(this.calcDistance(other)<other.getRadius()+this.radius){
      text("You Win", 500, 500);
      return true;
    }
    return false;
  }
}
