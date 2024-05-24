void setup(){
  size(1500,500);
  textSize(40);
  fill(0, 102, 153);
  text("This is da best project",0,40);
  
  
  Rope r = new Rope(new PVector(0,0), new PVector(0, 200), 10, 4, 10);
  r.display();
}
