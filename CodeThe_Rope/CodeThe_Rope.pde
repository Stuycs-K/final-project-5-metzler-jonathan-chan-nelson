map m;
PVector gravity;
Rope r;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  size(1500,900);  
  gravity = new PVector(0, 6);
  m=new map(1);
}
void draw() {
  background(255);
  m.display();
  m.move();
  //text(""+c.calcDistance(g), 20, 40);
  text("Earth Mode", 20, 20);
}
