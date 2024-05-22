ArrayList<Candy>candyList;
void setup() {
  size(1000, 700);
  candyList = new ArrayList<Candy>();
}
void mouseClicked() {
  //add a new Orb to the orbList, constructed as follows:
  //The x and y positions are the same as the mouse
  //the radius should be a random value in the range [20.0,70.0)
  //the xSpeed and ySpeed should be random values in the range [-3.0,3.0)
  float xSpeed=random(-3,3);
  float ySpeed=random(-3,3);
  Candy c = new Candy(mouseX,mouseY,xSpeed,ySpeed,20);
  candyList.add(c);
}
void draw() {
  background(255);
  for (Candy c : candyList) {
    c.move();
    c.display();
  }
  fill(0);
  text(frameRate,20,20);
  text(candyList.size(),20,40);
}
