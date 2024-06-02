public class Candy extends node{
  PVector velocity, acceleration;
  float radius;
  float mass;
  color c;
  PImage img;
  void move() {
      velocity.add(acceleration);
      position.add(velocity);
      acceleration=new PVector(0, 0);
  }
  
  void display(){
    imageMode(CENTER);
    image(img, position.x, position.y,radius+10,radius+10);
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
    img = loadImage("Candy.jpg");
  }
  public boolean offTheMap() {
    if (position.x < radius){
      return true;
    }
    if (position.x > width-radius){
      return true;
    }
    if (position.y < radius){
      return true;
    }
    if (position.y > height-radius){
      return true;
    }
      return false;
  }
}
