Map m;
PVectorD gravity = new PVectorD(0, 3);
float mouseStartx;
float mouseStarty;
float mouseEndx;
float mouseEndy;

static double SPRING_STIFFNESS = 10;
static double ENERGY_LOSS = 1;
PVectorD staticP = new PVectorD(0, 0);

//For Demo
boolean stroke;
PVectorD demoP1 = new PVectorD(400, 50);
PVectorD demoP2 = new PVectorD(200, 350);
double demoLFactor = 1;
double demoMass = 5; 
int demoNumNodes = 10;


void setup() {
  size(1500, 900);
  frameRate(1000);
  m=new Map(1);
  }

  void draw() {
    background(255);
    m.move();
    m.display();
  }

  void mousePressed() {
    mouseStartx=mouseX;
    mouseStarty=mouseY;
  }
  void mouseReleased() {
    m.mouseMovement(mouseStartx, mouseStarty, mouseX, mouseY);
    mouseEndx=mouseX;
    mouseEndy=mouseY;
  }
  
  void keyPressed() {
    if (key == ' '){
      m.start();
    }
    
    if (key == 's'){
      stroke = !stroke;
    }
  }
