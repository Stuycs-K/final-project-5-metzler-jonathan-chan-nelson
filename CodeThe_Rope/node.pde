public class node{
  PVector position;
  PShape s;
<<<<<<< HEAD
  public node(float x, float y, PShape shape_){
    position = new PVector(x, y);
    s=shape_;
  }
=======
>>>>>>> f06d170fcf168895e76f3813f6360be83bb5c5c2
  
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
