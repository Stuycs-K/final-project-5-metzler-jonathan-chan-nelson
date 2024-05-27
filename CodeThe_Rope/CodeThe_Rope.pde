Candy c;
PVector gravity;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  size(1200, 900);

  //CHANGE THIS
  //make earth (mass of 500million) place it very far off the bottom of the screen
  gravity = new PVector(0, 7.5);


  //DO NOT CHANGE THIS:
  c=new Candy(mouseX, mouseY, -1, 0, 20, 10);
}
void mouseClicked() {
  setup();
}

void draw() {
  background(255);
  c.move();
  c.display();
  c.applyForce(gravity);
  fill(0);
  text("Earth Mode", 20, 20);
}
