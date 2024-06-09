public class Bubble extends Node {

  public Bubble (double x, double y) {
    super(x, y, createShape(ELLIPSE, 0, 0, 20, 20), 20, color(100, 100, 100), loadImage("omNom.png"));
  }
}
