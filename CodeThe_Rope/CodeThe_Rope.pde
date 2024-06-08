Map m;
PVectorD gravity = new PVectorD(0, 20);
float mouseStartX = -1;
float mouseStartY = - 1;

boolean test;

static double SPRING_STIFFNESS = 10;
static double ENERGY_LOSS = 0.99999;
PVectorD staticP = new PVectorD(0, 0);
double dt = 0.0001;

//For Demo
boolean stroke;

void setup() {
  size(1500, 900);
  frameRate(200);
  m=new Map(1);
}

void draw() {
  background(255);
  m.move();
  m.display();
  if (mouseStartX != -1 && mouseStartY != -1) {
    float l = (float) Math.sqrt(Math.pow(mouseStartX - mouseX, 2) + Math.pow(mouseStartY - mouseY, 2));
    float angle = PI + atan((float) ((mouseStartY - mouseY)/(mouseStartX - mouseX)));
    translate(mouseStartX, mouseStartY);
    rotate(angle);
    if (mouseStartX >= mouseX) rect(0, -1.5, l, 3);
    else rect(0, -1.5, -l, 3);
    rotate(-angle);
    translate(-mouseStartX, -mouseStartY);
  }
}

void mousePressed() {
  if (mouseStartX != -1 && mouseStartY != -1) {
    m.mouseMovement(mouseStartX, mouseStartY, mouseX, mouseY);
    mouseStartX = -1;
    mouseStartX = -1;
  } else {
    mouseStartX=mouseX;
    mouseStartY=mouseY;
  }
}


void keyPressed() {
  if (key == 'r') setup();
  if (key == 's') stroke = !stroke;
  if (key == 't') test = !test;
}
