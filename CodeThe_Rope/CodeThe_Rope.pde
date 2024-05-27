void setup(){
  size(1500,1500);
  textSize(40);
  fill(0, 102, 153);
  text("This is da best project",0,40);
  
  PVector P1 = new PVector(20, 30);
  PVector P2 = new PVector(180, 320);
  float len = PVector.dist(P1, P2);
  try{
    Rope r = new Rope(P1, P2, len * 2, 4, 60);
    r.display();
  } catch(Exception e){
    print(e);
  }
}
