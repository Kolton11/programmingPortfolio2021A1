class PowerUp {
  int x, y, speed, rad, pu; 
  String[] puInfo = {"Ammo", "Health", "Lasers", "Super"};

  PowerUp(int x, int y) {
    rad = 50; 
    this.x = x;
    this.y = y;
    speed = int(random(2, 8));
    pu = int(random(4));
  }

  void move() {
    y += speed;
  }

  boolean reachedBottom() {
    if (y > height + rad*4) { 
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    switch(pu) {
    case 0: // Ammo
      fill(255,0,0);
      ellipse(x, y, rad, rad);
      fill(255);
      textSize(15);
      textAlign(CENTER);
      text(puInfo[0], x, y);
      break;
    case 1: // Health
      fill(10,247,229);
      ellipse(x,y,rad,rad);
      fill(255);
      textSize(15);
      textAlign(CENTER);
      text(puInfo[1], x, y);
      break;
    case 2: // Lasers
      fill(0,0,255);
      ellipse(x, y, rad, rad);
      fill(255);
      textSize(15);
      textAlign(CENTER);
      text(puInfo[2], x, y);
      break;
    case 3: // Super Weapon
      fill(#FFAF00);
      rectMode(CENTER);
      rect(x, y, rad, rad);
      fill(255);
      textSize(15);
      textAlign(CENTER);
      text(puInfo[3], x, y);
      break;
    }
  }
}
