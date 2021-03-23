class Rock {
  // member variables
  int x, y, speed, rad, health;
  color c;
  PImage rock;
  // constructor
  Rock(int x, int y) {
    this.x = x;
    this.y = y;
    speed = int(random(3,6));
    health = 25;
    rad = 25;
    rock =loadImage("rock.png");
  }  

  // display method
  void display() {
    image(rock,x,y);
    //rectMode(CENTER);
    //noStroke();
    //fill(c);
    //ellipse(x, y, 50, 50);
  }

  void move() {
    y+=speed;
  }

  // Rock vs Laser Collision
  boolean laserIntersection(Laser laser) {
    float distance = dist(x, y, laser.x, laser.y); 
    if (distance < rad + laser.rad) {
      return true;
    } else {
      return false;
    }
  }

  boolean reachedBottom() {
    if (y>height) {
      return true;
    } else {
      return false;
    }
  }
}
