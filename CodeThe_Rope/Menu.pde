public class Menu {
  private int levels;

  public Menu(int levels_) {
    levels=levels_;
  }
  public void display() {
    textSize(50);
    stroke(0);
    fill(50, 150, 50);
    text("Select a level", 600, 50);
    for (int i = 0; i < levels; i++) {
      fill(100, 200, 100);
      shape(createShape(RECT, 0, 0, 150, 150), (i % 3) * 500 + 150, (i / 3) * 500 + 150);
      fill(0);
      textSize(100);
      text("" + (i + 1), (i % 3) * 500 + 200, (i / 3) * 500 + 250);
    }
  }

  public int clicking(int x, int y) {
    if (x >= 150 && x <= 300 && y >= 150 && y <= 300) {
      return 1;
    } else if (x >= 650 && x <= 800 && y >= 150 && y <= 300) {
      return 2;
    } else if (x >= 1150 && x <= 1300 && y >= 150 && y <= 300) {
      return 3;
    } else if (x >= 150 && x <= 300 && x <= 300 && y >= 650 && y <= 800) {
      return 4;
    } else if (x >= 150 && x <= 800 && y >= 650 && y <= 800) {
      return 5;
    } else if (x >= 1150 && x <= 1300 && y >= 650 && y <= 800) {
      return 6;
    } else return 0;
  }
}
