class Spaceship {
  // member variables
  int x, y, health, lives, ammo, rad;
  // constructor
  Spaceship() {
    x = 0;
    y =0;
    health = 500;
    lives = 3;
    ammo = 500;
    rad = 25;
  }

  // display method
  void display(int x, int y) {
    this.x = x;
    this.y = y;
    rectMode(CENTER);
    fill(165, 125, 73);
    stroke(80);
    rect(x-15, y+10, 7, 7);
    rect(x+15, y+10, 7, 7);
    line(x-30, y-10, x-30, y+5);
    line(x+30, y-10, x+30, y+5);
    fill(24, 18, 222);
    triangle(x, y-15, x+35, y+10, x-35, y+10);
    fill(12, 237, 220);
    ellipse(x, y, 20, 70);
  }

  boolean enemyLaserIntersect(EnemyLaser elaser) {
    // Calculate distance
    float distance = dist(x, y, elaser.x, elaser.y); 

    // Compare distance to sum of radii
    if (distance < rad + elaser.r) { 
      return true;
    } else {
      return false;
    }
  }

  boolean rockIntersection(Rock rock) {
    float distance = dist(x, y, rock.x, rock.y); 
    if (distance < rad + rock.rad) {
      return true;
    } else {
      return false;
    }
  }

  boolean shipIntersect(Enemy enemy) {
    // Calculate distance
    float distance = dist(x, y, enemy.x, enemy.y); 

    // Compare distance to sum of radii
    if (distance < rad + enemy.r) { 
      return true;
    } else {
      return false;
    }
  }


  boolean puIntersect(PowerUp pu) {

    float distance = dist(x, y, pu.x, pu.y); 

    if (distance < rad + pu.rad) { 
      return true;
    } else {
      return false;
    }
  }
}
