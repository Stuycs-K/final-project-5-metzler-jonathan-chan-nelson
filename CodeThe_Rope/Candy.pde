public class Candy{
  float x,y;
  float dx,dy;
  float radius;
  color c;

  public Candy(float x_pos,float y_pos,float xSpeed, float ySpeed, float radius_ ){
    x = x_pos;
    y = y_pos;
    dx = xSpeed;
    dy = ySpeed;
    radius = radius_;
    //random color... why not.
    c = color(random(255),random(255),random(255));
  }


  void display(){
    //Part 1:
    //draw a circle at the x,y position, with the correct radius.
    //make sure it is the correct color
    //make sure you read the parameters of ellipse/circle, so that you have the correct size.
    //radius is NOT one of the parameters by default.
    circle(x,y,radius);
    fill(c);
  }

  void move(){
    //PART 2 VELOCITY
    //change the x based on the xSpeed
    //change the y based on the ySpeed
    x+=dx;
    y+=dy;
    //PART 3 BOUNCE
    //If you are touching any of the sides of the screen:
    //Change the direction of movement by negataing one of the velocity directions.
    if(x>width||x<0){
      dx=dx*-1;
    }
    if(y>height||y<0){
      dy=dy*-1;
    }
  }
}
