Map m;
Menu menu;
Pause p;
PImage background;
PVectorD gravity = new PVectorD(0, 4);
float mouseStartX;
float mouseStartY;
int level;

static double SPRING_STIFFNESS = 10;
static double ENERGY_LOSS = 0.999999;
PVectorD staticP = new PVectorD();
double dt = 0.0001;

void setup() {
  background = loadImage("codeTheRope.jpg");
  background.resize(1500, 900);
  size(1500, 900);
  frameRate(200);
  menu = new Menu(6);
  //menu.display();
  level = 0;
  mouseStartX=-1;
  mouseStartY=-1;
  p=new Pause();
  p.display();
}

void draw() {
  background(background);
  PImage rewind = loadImage("Rewind_button.jpg");
  if (level == 0) {
    menu.display();
  } else {
    m.move();
    m.display();
    image(rewind, 1400, 50, 50, 50);
    cutLine();
  }
}

void mousePressed() {
  if (level == 0) {
    level = menu.clicking(mouseX, mouseY);
    m = new Map(level);
  }
  else{
    if (mouseX > 1375 && mouseX < 1450 && mouseY > 50 && mouseY < 100) {
      setup();
    } else if (mouseStartX != -1 && mouseStartY != -1) {
      m.mouseMovement(mouseStartX, mouseStartY, mouseX, mouseY);
      mouseStartX = -1;
      mouseStartY = -1;
    } else {
      mouseStartX = mouseX;
      mouseStartY = mouseY;
    }
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
    for (float totalLen = 0; totalLen < len; totalLen += sectionLen + sectionDistance) {
      float addedLen = sectionLen;
      if (totalLen + sectionLen > len) addedLen = len - totalLen;
      if (mouseStartX >= mouseX) rect(totalLen, -1, addedLen, 2);
      else rect(-totalLen, -1, -addedLen, 2);
    }
    rotate(-angle);
    translate(-mouseStartX, -mouseStartY);
  }
}
