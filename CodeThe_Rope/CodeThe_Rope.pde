Candy c;
PVector gravity;
Rope r;
static float SPRING_CONSTANT = 0;
static float SPRING_LENGTH = 1;
static float SPRING_STIFFNESS= 10;
static float SPRING_DAMPEN = 1;
PVector P1 = new PVector(200, 200);
PVector P2 = new PVector(150, 400);
float len = PVector.dist(P1, P2);
int n = 2;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  size(1500,1000);  
  background(40);
  gravity = new PVector(0, 3);
  // Demonstrate stationary rope
  len *= 1.4;
  r = new Rope(P1, P2, len, len / n, n);
  SPRING_LENGTH = len / (n - 1);
  r.setColor(color(255, 0, 0));
  r.display();
}

void draw(){
}

void mouseClicked(){
}

void keyPressed(){
  background(color(40));
  
  if(key == 'p'){
    n++;
    r = new Rope(P1, P2, len, len / n, n);
    SPRING_LENGTH = len / (n - 1);
    r.setColor(color(255, 0, 0));
    r.display();
  }
  
  if(key == 'm'){
    r.getEndpointB().setMovable(!r.getEndpointB().getMovable());
    print("m");
  }
}
