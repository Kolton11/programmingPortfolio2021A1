void setup() {
  size(600, 400);
}

void draw() {
  background(252,250,250);
  // Vertical
  stroke(247,2,39);
  strokeWeight(5);
  line(300,0,300,height);
  for (int i=0; i<height; i+=20) {
    stroke(3,3,3);
    strokeWeight(2);
    line(296, i, 304, i);
    fill(3,3,3);
    textSize(8);
    text(i, 280, i); 
    textSize(15);
    String s = "Kolton Rudd A1 Temperature converter.";
    text(s,5,20,115,300);
    String d = "Move mouse up and down along the temperature scale.";
    text(d,490,10,115,300);
  }
  textSize(8);
  fill(229,208,140);
  ellipse(300,mouseY,10,10);
  fill(3,3,3);
  text("Cel:"+ convertToCel(mouseY),220, mouseY+10);
  text("Far:"+ convertToFar(mouseY),310,mouseY+10);
  //Horizontal
  //line(0, 100, width, 100);
  //for (int i=0; i<width; i+=20) {
    //line(i, 96, i, 104);
    //textSize(8);
    //text(i, i-7, 94);
  //}
  //ellipse(mouseX,100,5,5);
  //text("Cel:"+ convertToCel(mouseX),mouseX-30,115);
  //text("Far:"+ convertToFar(mouseX),mouseX-30,85);
}
float convertToCel(float val) {
  val = (val-32)*(5.0/9.0);
  return val;
}

float convertToFar(float val) {
  val = val*(9.0/5.0)+32;
  return val;
}
