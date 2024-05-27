public class node{
  PVector position;
  PShape s;
  color c;
  
  public node (float x, float y, PShape shape_, color c_){
    position = new PVector(x, y);
    s = shape_;
    c=c_;
  }
  void display() {
    fill(c);
    noStroke();
    shape(s,position.x,position.y);
  }
  void hide(){
    s.setVisible(false);
  }
  
  public float calcDistance(node other){
    float distance = PVector.dist(other.position, this.position);
    return distance;
  }
}
