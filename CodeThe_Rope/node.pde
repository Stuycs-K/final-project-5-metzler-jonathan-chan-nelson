public class node{
  PVector position;
  PShape s;
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
