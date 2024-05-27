Candy c;
goal g;
PVector gravity;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  size(1200, 900);

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
