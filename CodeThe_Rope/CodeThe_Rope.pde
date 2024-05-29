Candy c;
PVector gravity;
Rope r;
static double SPRING_CONSTANT = 0.00005;
static double SPRING_LENGTH = 0;
static double SPRING_DAMPEN = 0.99;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  gravity = new PVector(0.0, 0.005);
  size(1500,1500);  
  background(40);
  // Demonstrate stationary rope
  PVector P1 = new PVector(300, 30);
  PVector P2 = new PVector(500, 70);
  float len = PVector.dist(P1, P2);
  SPRING_LENGTH = len * 0.5;
  try{
    r = new Rope(P1, P2, len * 2, 0.02, 20);
    r.display();
  } catch(Exception e){
    print(e);
  }
}

void draw(){
  background(40);
  r.getEndpointB().setMovable(true);
  r = r.move();
  r.display();
}

void mouseClicked(){
}
