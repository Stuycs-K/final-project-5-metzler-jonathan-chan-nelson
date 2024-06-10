public class Bubble extends Node {
  Candy candyLink;

  public Bubble (double x, double y) {
    super(x, y, 50, loadImage("Bubble.png"));
  }

  public Candy getCandyLink() {
    return candyLink;
  }

  public void display() {
    if (candyLink != null) getPosition().set(candyLink.getPosition());
    fill(color(255, 255, 255, 150));
    circle((float) getPosition().x, (float) getPosition().y, 2 * (float)getRadius() * 0.8);
    tint(255, 127);
    super.display();
    tint(255, 255);
  }

  public void connect(Candy c) {
    gravity.mult(-0.01);
    candyLink = c;
  }

  public void pop() {
    gravity.div(-0.01);
    candyLink = null;
  }
}
