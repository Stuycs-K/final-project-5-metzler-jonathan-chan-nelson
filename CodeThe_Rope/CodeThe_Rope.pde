Candy c;
PVector gravity;
Rope r;
static double SPRING_CONSTANT = 0.005;
static double SPRING_LENGTH = 0;
static double SPRING_DAMPEN = 0.99;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  size(1500,1500);  
  background(40);
  gravity = new PVector(0, 0.8);
  // Demonstrate stationary rope
  PVector P1 = new PVector(200, 200);
  PVector P2 = new PVector(300, 300);
  float len = PVector.dist(P1, P2);
  SPRING_LENGTH = len * Math.sqrt(2);
  r = new Rope(P1, P2, len * 2, 200, 20);
  r.setColor(color(255, 0, 0));
}

void draw(){
  r.move();
  r.display();
}

void mouseClicked(){
  r.getEndpointB().setMovable(!r.getEndpointB().getMovable());
  r.move();
}
