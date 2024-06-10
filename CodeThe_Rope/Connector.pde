public class Connector extends Node {
  private double connectRadius = 200;
  private boolean connected = false;
  
  public Connector (double x, double y) {
    super(x, y, 50, loadImage("Connector.png"));
  }
  
  public double getConnectRadius(){
    return connectRadius;
  }
  
  public boolean getConnected(){
    return connected;
  }
  
  public void setConnected(boolean b){
    connected = b;
  }
  
  public void display(){
    super.display();
    fill(color(255, 255, 255, 150));
    double circum = 2 * Math.PI * connectRadius;
    float sectionLen = 20;
    float sectionDistance = 5;
    float angle = atan(sectionLen / (float) (connectRadius));
    float angle2 = atan(sectionDistance / (float) (connectRadius));
    translate((float) (getPosition().x + connectRadius), (float) getPosition().y);
    int i = 0;
    for (float totalLen = 0; totalLen + sectionLen + sectionDistance < circum; totalLen += sectionLen + sectionDistance) {
      rect(0, -1, 4, sectionLen);
      translate(0, -(sectionLen + sectionDistance));
      rotate(-angle);
      rotate(-angle2);
      i++;
    }
    while(i > 0){
      rotate(angle2);
      rotate(angle);
      translate(0, (sectionLen + sectionDistance));
      i--;
    }
    translate((float) -(getPosition().x + connectRadius), (float) -getPosition().y);
  }
}
