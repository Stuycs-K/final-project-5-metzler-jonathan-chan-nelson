Candy c;
PVector gravity;
Rope r;
static float SPRING_CONSTANT = 0.5;
static float SPRING_LENGTH = 1;
static float ENERGY_LOSS = 0.99;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  size(1500,750);  
  background(40);
  frameRate(2000);
  gravity = new PVector(0, 3 );
  // Demonstrate stationary rope
  PVector P1 = new PVector(200, 200);
  PVector P2 = new PVector(400, 400);
  float len = PVector.dist(P1, P2);
  len *= 1.8;
  int n = 40;
  r = new Rope(P1, P2, len, 4 * n, n);
  SPRING_LENGTH = len / (n - 1);
}


void draw(){
  background(color(40));
  r.move();
  r.display();
}

void mouseClicked(){
}

void keyPressed(){
  background(color(40));
  r.move();
  
  if(key == 'm'){
    r.getEndpointB().setMovable(!r.getEndpointB().getMovable());
  }
}
