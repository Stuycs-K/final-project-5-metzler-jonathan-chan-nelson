public class Connector extends Node {
  private double connectRadius = 500;
  private boolean connected = false;
  
  public Connector (double x, double y) {
    super(x, y, createShape(ELLIPSE, 0, 0, 20, 20), 20, color(100, 100, 100), loadImage("omNom.png"));
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
}
