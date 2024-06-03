public class node {
  PVectorD position;
  PShape s;
  color c;

  public node (float x, float y, PShape shape_, color c_) {
    position = new PVectorD(x, y);
    s = shape_;
    c=c_;
  }
  void display() {
    shape(s, (float) position.x, (float) position.y);
    s.setFill(c);
  }
  void hide() {
    s.setVisible(false);
  }

  public double calcDistance(node other) {
    double distance = staticP.dist(other.position, this.position);
    return distance;
  }
}
