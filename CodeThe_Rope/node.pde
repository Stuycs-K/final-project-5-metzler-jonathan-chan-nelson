public class node{
  PVector position;
  PShape s;
<<<<<<< HEAD
  
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
=======
  public node(float x, float y, PShape shape_){
    position = new PVector(x, y);
<<<<<<< HEAD
    s=shape_;
=======
    shape=shape_;
>>>>>>> 862e2eb844ca1e82ed946ac7b676b5578db51668
  }
  
  void display(){
    shape(s,position.x,position.y);
  }
  void hide(){
<<<<<<< HEAD
    s.setVisible(false);
=======
    setVisible(false);
>>>>>>> 862e2eb844ca1e82ed946ac7b676b5578db51668
  }
}
