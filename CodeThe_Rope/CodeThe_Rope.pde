Map m;
PVectorD gravity = new PVectorD(0, 1);
float mouseStartx;
float mouseStarty;

static double SPRING_STIFFNESS = 20;
static double ENERGY_LOSS = 1;
PVectorD staticP = new PVectorD(0, 0);

//For Demo
boolean stroke;
PVectorD demoP1 = new PVectorD(200, 50);
PVectorD demoP2 = new PVectorD(500, 100);
PVectorD demoP3 = new PVectorD(600, 50);
double demoLFactor = 1;
double demoMass = 5; 
int demoNumNodes = 5;


void setup() {
  size(1500, 900);
  frameRate(1000);
  m=new Map(1);
  }

  void draw() {
    background(255);
    rect(500, 100, 50, 50);
    m.move();
    m.display();
  }

  void mousePressed() {
    mouseStartx=mouseX;
    mouseStarty=mouseY;
  }
  void mouseReleased() {
    m.mouseMovement(mouseStartx, mouseStarty, mouseX, mouseY);
  }
  
  void keyPressed() {
    if (key == ' '){
      m.start();
    }
    
    if (key == 's'){
      stroke = !stroke;
    }
  }
