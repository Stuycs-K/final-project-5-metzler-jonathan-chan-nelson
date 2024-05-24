public class node{
  PVector position;
  PShape s;
  
  public node (float x, float y, shape_){
    position = new PVector(x, y);
    s = shape_;
  }
  void display() {
    fill(0,0,0);
    noStroke();
    shape(s,position.x,position.y);
  }
  void hide(){
    shape.setVisible(false);
  }
}
