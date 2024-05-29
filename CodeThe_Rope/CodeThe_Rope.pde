Candy c;
PVector gravity;
Rope r;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  gravity = new PVector(0.0, 0.3);
  size(1500,1500);  
  // Demonstrate stationary rope
  PVector P1 = new PVector(20, 30);
  PVector P2 = new PVector(120, 240);
  float len = PVector.dist(P1, P2);
  try{
    r = new Rope(P1, P2, len * 2, 4, 500);
    r.display();
  } catch(Exception e){
    print(e);
  }
}

void draw(){
}

void mouseClicked(){
  r.getEndpointB().setMovable(true);
  if(r != null){
    r = r.move();
    r.display();
  }
}
