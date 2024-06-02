map m;
PVector gravity;
Rope r;


void setup() {
  size(1500,900);  
  gravity = new PVector(0, 6);
  m=new map(1);
}
void draw() {
  background(255);
  m.display();
  m.move();
}
