public class Menu{
  int levels;
  public Menu(int levels_){
    levels=levels_;
  }
  public void display(){
    for(int i=0;i<levels;i++){
      fill(255);
      shape(createShape(RECT, 150, 150, 150, 150), (i%3)*500, (i/3)*500);
      fill(0);
      textSize(100);
      text(""+i,(i%3)*500+200, (i/3)*500+250);
      
    }
  }
}
