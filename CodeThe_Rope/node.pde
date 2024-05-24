public class node{
  PVector position;
  PShape s;
  public node(float x, float y, PShape shape_){
    position = new PVector(x, y);
    s=shape_;
  }
  
  void display(){
    shape(s,position.x,position.y);
  }
  void hide(){
    s.setVisible(false);
  }
}
