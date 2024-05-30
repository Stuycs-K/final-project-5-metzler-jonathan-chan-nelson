Candy c;
goal g;
PVector gravity;
Rope r;

/**
 *IN THIS TAB: MODIFY YOUR SETUP BEFORE YOU EDIT ORB
 */

void setup() {
<<<<<<< HEAD
  size(1500,900);  
  /*
=======
  gravity = new PVector(0.0, 0.3);
  size(1500,1500);  
>>>>>>> 9ec7ac89032a4f9343291a6f63fb4feb4f58ba10
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
<<<<<<< HEAD
  */
  gravity = new PVector(0, 6);

  c=new Candy(mouseX, mouseY, -1, 0, 10, 20);
  g=new goal(500,500,20);
=======
>>>>>>> 9ec7ac89032a4f9343291a6f63fb4feb4f58ba10
}

void draw(){
}

<<<<<<< HEAD
void draw() {
  background(255);
  c.move(g);
  c.display();
  g.display();
  c.applyForce(gravity);
  fill(0);
  //text(""+c.calcDistance(g), 20, 40);
  text("Earth Mode", 20, 20);
=======
void mouseClicked(){
  r.getEndpointB().setMovable(true);
  if(r != null){
    r = r.move();
    r.display();
  }
>>>>>>> 9ec7ac89032a4f9343291a6f63fb4feb4f58ba10
}
