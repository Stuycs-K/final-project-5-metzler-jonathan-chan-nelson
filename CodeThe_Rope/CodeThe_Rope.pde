Candy c;
goal g;
PVector gravity;
Rope r;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
  size(1500,900);  
  gravity = new PVector(0, 6);

  c=new Candy(100, 100, -1, 0, 10, 20);
  g=new goal(500,500,40);
}
void draw() {
  background(255);
  c.move(g);
  c.display();
  g.display();
  c.applyForce(gravity);
  fill(0);
  //text(""+c.calcDistance(g), 20, 40);
  text("Earth Mode", 20, 20);
}
void mouseClicked(){
  c=new Candy(mouseX, mouseY, -1, 0, 10, 20);
}
