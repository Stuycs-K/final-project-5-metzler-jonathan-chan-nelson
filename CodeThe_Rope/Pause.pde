public class Pause {
  
  public Pause() {
  }
  public void display() {
    fill(100,200,100);
    shape(createShape(RECT, 0, 0, 1000, 500), 250, 200);
    fill(255);
    shape(createShape(RECT, 0, 0, 200, 200), 350, 350);
    shape(createShape(RECT, 0, 0, 200, 200), 450, 350);
    shape(createShape(RECT, 0, 0, 200, 200), 550, 350);
    text("Select a level", 600,50);
    
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
