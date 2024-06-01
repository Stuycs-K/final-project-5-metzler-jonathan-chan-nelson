  public class node{
  PVector position;
  PShape s;
  
  public node (float x, float y, PShape shape_){
    position = new PVector(x, y);
    s = shape_;
  }
  void display() {
    fill(255,255,255);
    noStroke();
    shape(s,position.x,position.y);
  }
  void hide(){
    s.setVisible(false);
  }
}
