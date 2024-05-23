Candy c;
Candy earth, center;
static double G = 20;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  size(1200, 900);

  //CHANGE THIS
  //make earth (mass of 500million) place it very far off the bottom of the screen
  earth = new Candy(width/2,height*200,0,0,20,500000000);


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
      c.applyForce(c.attractTo(earth));
  fill(0);
    text("Earth Mode", 20, 20);
}
