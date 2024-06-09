Map m;
PVectorD gravity = new PVectorD(0, 4);
float mouseStartX = -1;
float mouseStartY = -1;

static double SPRING_STIFFNESS = 10;
static double ENERGY_LOSS = 0.999995;
PVectorD staticP = new PVectorD();
double dt = 0.0001;

void setup() {
  size(1500, 900);
  frameRate(200);
  m = new Map(1);
}

void draw() {
  background(255);
  m.move();
  m.display();
  cutLine();
}

void mousePressed() {
  if (mouseStartX != -1 && mouseStartY != -1) {
    m.mouseMovement(mouseStartX, mouseStartY, mouseX, mouseY);
    mouseStartX = -1;
    mouseStartX = -1;
  } else {
    mouseStartX = mouseX;
    mouseStartY = mouseY;
  }
}

void cutLine() {
  if (mouseStartX !=-1 && mouseStartY !=-1) {
    fill(color(255, 255, 255));
    float len = (float) Math.sqrt(Math.pow(mouseStartX - mouseX, 2) + Math.pow(mouseStartY - mouseY, 2));
    float angle = PI + atan((float) ((mouseStartY - mouseY) / (mouseStartX - mouseX)));
    float sectionLen = 20;
    float sectionDistance = 5;
    translate(mouseStartX, mouseStartY);
    rotate(angle);
    for(float totalLen = 0; totalLen < len; totalLen += sectionLen + sectionDistance){
      float addedLen = sectionLen;
      if (totalLen + sectionLen > len) addedLen = len - totalLen;
      if (mouseStartX >= mouseX) rect(totalLen, -1, addedLen, 2);
      else rect(-totalLen, -1, -addedLen, 2);
    }
    rotate(-angle);
    translate(-mouseStartX, -mouseStartY);
  }
}


void keyPressed() {
  if (key == 'r') setup();
}
