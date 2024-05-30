Candy c;
PVector gravity;
Rope r;
static double SPRING_CONSTANT = 0.0005;
static double SPRING_LENGTH = 0;
static double SPRING_DAMPEN = 0.999;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  gravity = new PVector(0.0, 0.04);
  size(1500,1500);  
  background(40);
  // Demonstrate stationary rope
  PVector P1 = new PVector(400, 400);
  PVector P2 = new PVector(600, 500);
  float len = PVector.dist(P1, P2);
  r = new Rope(P1, P2, len * 2, 200, 100);
  r.display();
}

void draw(){
  background(40);
  if(r.getEndpointB().getVelocity().mag() == 0  || r.getEndpointB().getVelocity().mag() > 0.01){
    println(r.getEndpointB().getVelocity().mag());
    r.move();
  }
  r.display();
}

void mouseClicked(){
  r.getEndpointB().setMovable(true);
}
