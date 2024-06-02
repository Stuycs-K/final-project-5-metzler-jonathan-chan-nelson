map m;
PVector gravity;
Rope r;
static float SPRING_CONSTANT = 0.5;
static float SPRING_LENGTH = 1;
static float ENERGY_LOSS = 0.99;


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

void mouseClicked(){
}
