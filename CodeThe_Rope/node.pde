public class Node {
  private PVectorD position;
  private PImage img;
  private double radius;

  public Node (double x, double y, double r, PImage img_) {
    position = new PVectorD(x, y);
    radius = r;
    img = img_;
  }

  public double getRadius() {
    return radius;
  }

  public PVectorD getPosition() {
    return position;
  }

  public void display() {
    imageMode(CENTER);
    image(img, (float) position.x, (float) position.y, 2 * (float) radius, 2 * (float) radius);
  }

  public double calcDistance(Node other) {
    return staticP.dist(other.position, this.position);
  }
}
