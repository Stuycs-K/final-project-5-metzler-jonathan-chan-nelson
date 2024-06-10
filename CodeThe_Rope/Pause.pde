public class Pause {
  PImage rewind = loadImage("Rewind_button.jpg");
  PImage menu = loadImage("Menu.jpg");
  public Pause() {
  }
  public void display() {
    stroke(0);
    fill(100,200,100);
    shape(createShape(RECT, 0, 0, 750, 300), 375, 300);
    fill(255);
    imageMode(CORNER);
    image(rewind, 450, 400, 150, 150);
    image(menu, 675, 400, 150, 150);
    shape(createShape(RECT, 0, 0, 150, 150), 900, 400);
    fill(0);
    triangle(930, 425, 930, 525, 1025, 475);
  }

  public int clicking(int x, int y) {
    if (x >= 450 && x <= 600 && y >= 400 && y <= 550) {
      return 1;
    } else if (x >= 675 && x <= 825 && y >= 400 && y <= 550) {
      return 2;
    } else if (x >= 900 && x <= 1150 && y >= 400 && y <= 550) {
      return 3;
    } else return -1;
  }
}
