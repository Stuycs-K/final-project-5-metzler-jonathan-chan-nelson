public class Candy {
  PVector position, velocity, acceleration;
  float radius;
  float mass;
  color c;
  /**
   *IN THIS TAB MODIFY:
   *move()
   *attractTo()
   *applyForce()
   */



  void move() {
    //You have 3 PVectors, acceleration, velocity, and position.
    //1. apply acceleration to velocity
    //2. apply velocity to position
    //3. reset acceleration to 0 so that forces do not accumulate
    velocity.add(acceleration);
    position.add(velocity);
    acceleration=new PVector(0, 0);
    youLose();
  }


  /**
   *Calculate the force between this orb and the other orb.
   *Return a PVector with the correct magnitude and direction
   */
  PVector attractTo(Candy other) {
    //You should be familiar with the formular from physics: g = G*M1*M2/dist^2
    //G is a gravitational constant
    //M1 and M2 are the masses of this Orb, and the other Orb.
    //dist is the distance between the dist.

    //CHANGE THIS
    //calculate the distance from this orb to other orb
    //float distance = position.dist(other.position);
    float distance = PVector.dist(other.position, this.position);

    //DO NOT CHANGE THIS:
    //this code prevents small distances creating problems (overlapping orbs with 0 dist)
    distance = max(15.0, distance);

    //CHANGE THIS
    //calculate the magnitude of the force g using the formula g = G*M1*M2/dist^2
    double mag = G*mass*other.mass/distance/distance;

    //CHANGE THIS
    //calculate the direction of the force
    PVector force = PVector.sub(other.position,this.position);

    //CHANGE THIS
    //normalize the force
    force.normalize();
    //CHANGE THIS
    //now you have a unit vector, and a magnitude.
    //Make your force vector have the correct magnitude before returning it.
    force.mult((float)mag);

    //DO NOT CHANGE THIS
    return force;
  }

  /*Apply a force to the current orb by changing the acceleration.*/
  void applyForce(PVector f) {
    //knowing that f = ma, you can rearrange the formula to see how you want to manipulate acceleration:
    //a = f / m
    //CHANGE THIS
    //add  force/mass to the acceleration to apply the force.
    acceleration.add(PVector.div(f,mass));
  }

  //DO NOT CHANGE THINGS BELOW THIS POINT
  //DO NOT CHANGE THINGS BELOW THIS POINT
  //DO NOT CHANGE THINGS BELOW THIS POINT

  public Candy(float x, float y, float xSpeed, float ySpeed, float radius_, float mass_ ) {
    position = new PVector(x, y);
    velocity = new PVector(xSpeed, ySpeed);
    acceleration = new PVector(0, 0);
    mass = mass_;
    radius = radius_;
    c = color(random(255), random(255), random(255));
  }


  void display() {
    fill(c);
    noStroke();
    circle(position.x, position.y, (float)radius*2);
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
