public class spike extends node{
  float radius;
  PImage img;
  public spike (float x, float y){
    super(x,y,createShape(ELLIPSE, 0, 0, 20, 20),color(100,100,100));
    radius=20;
    img = loadImage("omNom.png");
  }
  public float getRadius(){
    return radius;
  }
  
}
