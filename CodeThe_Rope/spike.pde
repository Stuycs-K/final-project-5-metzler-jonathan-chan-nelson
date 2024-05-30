public class spike extends node{
  float radius;
  PImage img;
  public goal (float x, float y, float len, float orientation){
    super(x,y,createShape(RECT, 0, 0, 50, len),color(0,255,0));
    radius=radius_;
    img = loadImage("omNom.png");
  }
  void display(){
    imageMode(CENTER);
    image(img, position.x, position.y,radius+10,radius+10);
  }
  public float getRadius(){
    return radius;
  }
  
}
