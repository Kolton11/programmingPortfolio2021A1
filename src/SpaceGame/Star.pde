class Star {
  // member variables
  int x, y, speed, dia;
  color c;
  // constructor
  Star(int x, int y) {
    this.x = x;
    this.y = y;
    c = color(255);
    speed = int(random(1, 6));
    dia = int(random(1, 4));
  }

  // display method
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(c);
    ellipse(x, y, dia, dia);
  }

  void move() {
    y+=speed;
  }

  boolean reachedBottom() {
    if (y>height+50) {
      return true;
    } else {
      return false;
    }
  }
}
