Candy c;
PVectorD gravity;
Rope r;
static double SPRING_CONSTANT;
static double SPRING_LENGTH;
static double ENERGY_LOSS = 0.9999;

PVectorD staticP = new PVectorD(0, 0);
/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  size(1500,750);  
  background(40);
  frameRate(100000);
  gravity = new PVectorD(0, 2);
  // Demonstrate stationary rope
  PVectorD P1 = new PVectorD(200, 200);
  PVectorD P2 = new PVectorD(300, 300);
  double len = 1 * staticP.dist(P1, P2);
  int n = 4;
  SPRING_LENGTH = len / (n - 1);
  SPRING_CONSTANT = 10 * n;
  r = new Rope(P1, P2, len, 5 * n, n);
  PVectorD P3 = new PVectorD(350, 150);
  double len2 = 1 * staticP.dist(P1, P2);
  r = new Rope(P3, P2, len2, 5 * n, n);
}


void draw(){
  background(color(40));
  r.display();
  r.move();
  rect(450, 450, 5, 5);
  rect(350, 350, 5, 5);
}

void mouseClicked(){
}

void keyPressed(){
  background(color(40));
  
  if(key == 'm'){ 
    r.getEndpointB().setMovable(!r.getEndpointB().getMovable());
  }
  
  if(key == 'a'){
    RopeNode target = r.getEndpointB();
    target.setMass(target.getMass() + 20);
  }
}
