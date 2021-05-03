void setup(){
  //Set the size of the window
  size(500,500);
}

void draw() {
  
  //background(255,100,50);
  zoog(mouseX,mouseY);
  zoog(mouseX-100,mouseY);
  zoog(mouseX+100,mouseY);
  zoog(width/2, height/2);
  zoog(int(random(width)), int(random(height)));
 
  //Set CENTER mode
  
}

void zoog(int x, int y) {
  ellipseMode(CENTER);
  rectMode(CENTER);
  
  // body
  stroke(0);
  fill(3,255,12);
  rect(x,y,20,100);
  
  // head
  stroke(0);
  fill(255);
  ellipse(x,y-30,60,60);
  
  // eyes
  fill(3,88,255);
  ellipse(x-19,y-30,16,32);
  ellipse(x+19,y-30,16,32);
  
  // legs
  stroke(0);
  line(x-10,y+50,x-20,y+60);
  line(x+10,y+50,x+20,y+60);
}
