public class Node {
  private PVectorD position;
  private PImage img;
  private double radius;
  private color c;

  public Node (double x, double y, PShape shape_, double r, color c_, PImage img_) {
    position = new PVectorD(x, y);
    radius = r;
    c = c_;
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
    image(img, (float) position.x, (float) position.y, (float) radius + 10, (float) radius + 10);
  }

  public double calcDistance(Node other) {
    double distance = staticP.dist(other.position, this.position);
    return distance;
  }
}
