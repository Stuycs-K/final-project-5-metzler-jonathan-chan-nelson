Map m;
Menu menu;
Pause p;
PImage background;
PVectorD gravity = new PVectorD(0, 5);
float mouseStartX;
float mouseStartY;
int level;
int temp;

static double SPRING_STIFFNESS = 3;
static double ENERGY_LOSS = 0.999995;
PVectorD staticP = new PVectorD();
double dt = 0.0001;

void setup() {
  background = loadImage("codeTheRope.jpg");
  background.resize(1500, 900);
  size(1500, 900);
  frameRate(50);
  menu = new Menu(6);
  level = 0;
  mouseStartX = -1;
  mouseStartY = -1;
  p = new Pause();
}

void draw() {
  textSize(50);
  noStroke();
  background(background);
  PImage pause = loadImage("Pause.png");
  if (level == 0) {
    menu.display();
  } else if (level == -1) {
    p.display();
    if (m.getEnd() == -1) {
      level = -1;
      fill(0);
      text("You Lost", 650, 200);
    }
    if (m.getEnd() == 1) {
      level = -1;
      fill(0);
      text("You Won", 650, 200);
      text("Stars Collected: " + m.getScore(), 650, 250);
    }
  } else {
    m.move();
    m.display();
    fill(255);
    shape(createShape(RECT, 0, 0, 50, 50), 1375, 25);
    image(pause, 1400, 50, 50, 50);
    cutLine();
    if (m.getEnd() == -1) {
      level = -1;
      fill(0);
      text("You Lost", 650, 200);
    }
    if (m.getEnd() == 1) {
      level = -1;
      fill(0);
      text("You Won", 650, 200);
      text("Stars Collected: " + m.getScore(), 650, 250);
    }
  }
}

void mousePressed() {
  //println(mouseX + "    " + mouseY);
  if (level == 0) {
    level = menu.clicking(mouseX, mouseY);
    m = new Map(level);
  } else if (level == -1) {
    int index = p.clicking(mouseX, mouseY);
    if (index == 1) {
      level = temp;
      gravity = new PVectorD(0, 5);
      m = new Map(level);
    } else if (index == 2) {
      gravity = new PVectorD(0, 5);
      setup();
    } else if (index == 3) {
      level=temp;
    }
  } else {
    if (mouseX > 1375 && mouseX < 1450 && mouseY > 50 && mouseY < 100) {
      print("1");
      temp = level;
      level =-1;
    } else if (!m.pop(mouseX, mouseY) && mouseStartX != -1 && mouseStartY != -1) {
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
