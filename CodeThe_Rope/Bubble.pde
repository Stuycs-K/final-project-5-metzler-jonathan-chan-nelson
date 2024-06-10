public class Bubble extends Node {
  Candy candyLink;

  public Bubble (double x, double y) {
    super(x, y, 70, loadImage("Bubble.png"));
  }
  
  public Candy getCandyLink() {
    return candyLink;
  }

  public void display() {
    if(candyLink != null) getPosition().set(candyLink.getPosition());
    fill(color(255, 255, 255, 150));
    circle((float) getPosition().x, (float) getPosition().y, 2 * (float)getRadius() * 0.8);
    super.display();
  }

  public void connect(Candy c) {
<<<<<<< HEAD
    gravity.mult(-0.1);
=======
    gravity.mult(-0.01);
>>>>>>> a168bf77d21a965d9c16bf1477063f1d55bee8cc
    candyLink = c;
  }

  public void pop() {
<<<<<<< HEAD
    gravity.mult(-10);
=======
    gravity.div(-0.01);
>>>>>>> a168bf77d21a965d9c16bf1477063f1d55bee8cc
    candyLink = null;
  }
}
