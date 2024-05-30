public class goal extends node{
  float radius;
  PImage img;
  public goal (float x, float y, float radius_){
    super(x,y,createShape(ELLIPSE, 0, 0, radius_, radius_),color(0,255,0));
    radius=radius_;
    img = loadImage("omNom.png");
  }
  void display(){
    image(img, position.x, position.y,radius+10,radius+10);
  }
  public float getRadius(){
    return radius;
  }
  
}
