Candy c;
goal g;
PVector gravity;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  size(1500,1500);  
  // Demonstrate stationary rope
  PVector P1 = new PVector(20, 30);
  PVector P2 = new PVector(180, 320);
  float len = PVector.dist(P1, P2);
  try{
    Rope r = new Rope(P1, P2, len * 2, 4, 60);
    r.display();
  } catch(Exception e){
    print(e);
  }
  

  //CHANGE THIS
  //make earth (mass of 500million) place it very far off the bottom of the screen
  gravity = new PVector(0, 6);


  //DO NOT CHANGE THIS:
  c=new Candy(mouseX, mouseY, -1, 0, 20, 10);
  g=new goal(0,0,20);
}

void mouseClicked() {
  setup();
}

void draw() {
  background(255);
  c.move(g);
  c.display();
  g.display();
  c.applyForce(gravity);
  fill(0);
  text("Earth Mode", 20, 20);
}
