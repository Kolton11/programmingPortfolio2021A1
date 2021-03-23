class Enemy {
  int r, health, x, y, speed, healthStart;
  boolean right;
  int savedTime; 
  int totalTime;

  Enemy(int x, int y, int t, int health) {
    healthStart = health;
    r = 25;
    this.x = x;
    this.y = y;
    this.health = health;
    speed = 5;
    this.totalTime = t;
  }

  void display() {
    fill(165, 125, 73);
    stroke(80);
    rect(x-15, y+10, 7, 7);
    rect(x+15, y+10, 7, 7);
    fill(255, 0, 77);
    line(x-30, y+30, x-30, y+10);
    line(x+30, y+30, x+30, y+10);
    fill(24, 18, 222);
    triangle(x, y+30, x+35, y+10, x-35, y+10);
    fill(12, 237, 220);
    ellipse(x, y+10, 20, 80);
    fill(0);
    textSize(12);
    textAlign(CENTER);
    text(health, x, y);
  }

  void move() {
    x += speed;
    if (x >= width|| x <= 0) {
      speed *= -1;
      y+=50;
    }
  }

  boolean laserIntersect(Laser laser) {
    // Calculate distance
    float distance = dist(x, y, laser.x, laser.y); 

    // Compare distance to sum of radii
    if (distance < r + laser.rad) { 
      return true;
    } else {
      return false;
    }
  }

  void start() {
    savedTime = millis();
  }


  boolean isFinished() { 
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
