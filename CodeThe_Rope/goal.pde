public class Goal extends Node {

  public Goal (double x, double y, float r) {
    super(x, y, createShape(ELLIPSE, 0, 0, r, r), r, color(0, 255, 0), loadImage("omNom.png"));
  }
}
