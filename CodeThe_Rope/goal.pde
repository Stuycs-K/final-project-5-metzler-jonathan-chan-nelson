public class goal extends node{
  float radius;
  public goal (float x, float y, float radius_){
    super(x,y,createShape(ELLIPSE, 0, 0, radius_, radius_),color(0,255,0));
    radius=radius_;
  }
  public float getRadius(){
    return radius;
  }
  
}
