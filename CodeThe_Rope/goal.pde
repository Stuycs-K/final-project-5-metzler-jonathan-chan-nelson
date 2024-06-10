public class Goal extends Node {

  public Goal (double x, double y) {
    super(x, y, 40, loadImage("omNom.png"));
  }
  
  public void display(){
    fill(color(212, 166, 114));
    rect((float) getPosition().x - 45, (float) getPosition().y + 25, 90, 20);
    super.display();
  }
}
