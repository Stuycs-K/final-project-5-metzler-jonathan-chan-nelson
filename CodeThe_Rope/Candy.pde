public class Candy extends node{
  PVector velocity, acceleration;
  float radius;
  float mass;
  color c;
  void move(goal other) {
    if(youWin(other)){}
    else if(youLose()){}
    else{
      velocity.add(acceleration);
      position.add(velocity);
      acceleration=new PVector(0, 0);
    }
  }

  void applyForce(PVector f) {
    acceleration.add(PVector.div(f,mass));
  }
  public Candy(float x, float y, float xSpeed, float ySpeed, float mass_, float radius_ ) {
    super(x,y,createShape(ELLIPSE, 0, 0, radius_, radius_),color(255,0,0));
    velocity = new PVector(xSpeed, ySpeed);
    acceleration = new PVector(0, 0);
    mass = mass_;
    radius = radius_;
  }
  
  public boolean youLose() {
    if (position.x < radius){
      text("You Lose", 1000, 500);
      return true;
    }
    if (position.x > width-radius){
      text("You Lose", 1000, 500);
      return true;
    }
    if (position.y < radius){
      text("You Lose", 1000, 500);
      return true;
    }
    if (position.y > height-radius){
      text("You Lose", 1000, 500);
      return true;
    }
      return false;
  }
  
  public boolean youWin(goal other) {
    if(this.calcDistance(other)<(other.getRadius()+this.radius)/2){
      text("You Win", 1000, 500);
      return true;
    }
    return false;
  }
}
