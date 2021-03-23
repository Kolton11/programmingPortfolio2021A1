//SpaceGame
// by Kolton Rudd Dec. 2020
Spaceship ship;
ArrayList<Laser> lasers;
ArrayList<Rock> rocks;
ArrayList<Star> stars;
ArrayList<Enemy> enemies;
ArrayList<EnemyLaser> elasers;
ArrayList<PowerUp> pUps;
boolean play;
Timer rockTimer, enemyTimer, ticTimer, puTimer;
int pass, rockRate, level, rockCount, laserCount, score, weaponCount, enemyHealth, superWeapon;
String ticText;
boolean ticker;

void setup() {
  size(900, 900);
  ship = new Spaceship();
  lasers = new ArrayList();
  rocks = new ArrayList();
  stars = new ArrayList();
  enemies = new ArrayList();
  elasers = new ArrayList();
  pUps = new ArrayList();
  rockRate = 1000;
  rockTimer = new Timer(rockRate);
  enemyTimer = new Timer(5000);
  puTimer = new Timer(5000);
  pass = 0;
  level = 1;
  rockCount = 0;
  laserCount = 0;
  score = 0;
  weaponCount = 1;
  enemyHealth = 100;
  superWeapon = 0;
  play = false;
  ticText = "";
  ticTimer = new Timer(2000);
  ticker = false;
  rockTimer.start();
  puTimer.start();
}

void draw() {
  noCursor();
  // GamePlay
  if (!play) {
    startScreen();
  } else {
    background(11);
    // Level Handling 
    if (frameCount % 1000 == 10) {
      level++;
      if (superWeapon > 0) {
        ticText = "Level: " + level + " And Super Weapon is ready!";
      } else {
        ticText = "Level: " + level;
      }

      ticker();
      rockRate-=90;
      enemyHealth+=100;
      rockTimer.totalTime = rockRate;
    }

    stars.add(new Star(int(random(width)), 0));
    for (int i = 0; i < stars.size(); i++) {
      Star star = stars.get(i);
      star.display();
      star.move();
      if (star.reachedBottom()) {
        stars.remove(star);
      }
    }

    if (enemyTimer.isFinished()) {
      enemies.add(new Enemy(0, 80, int(random(500, 1500)), enemyHealth));
      enemyTimer.start();
    }

    for (int i = 0; i<enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      enemy.move();
      enemy.display();
      // enemy and ship intersection
      if (ship.shipIntersect(enemy)) {
        ship.health-=10;
        score+=enemy.healthStart;
        enemies.remove(enemy);
      }
      if (enemy.isFinished()) {
        elasers.add(new EnemyLaser(enemy.x, enemy.y));
        enemy.start();
      }
    }

    for (int i = elasers.size()-1; i>=0; i--) {
      EnemyLaser elaser = (EnemyLaser) elasers.get(i);
      elaser.fire();
      elaser.display();
      // Enemy Laser vs. Ship
      if (ship.enemyLaserIntersect(elaser)) {
        ship.health-=elaser.power;
        elasers.remove(elaser);
      }
      if (elaser.reachedBottom()) {
        elasers.remove(elaser);
      }
    }
    if (rockTimer.isFinished()) {
      rocks.add(new Rock(int(random(width)), -20));
      rockCount++;
      rockTimer.start();
    }

    for (int i = 0; i < rocks.size(); i++) {
      Rock rock = rocks.get(i);
      rock.display();
      rock.move();
      //Detect ship collision
      if (ship.rockIntersection(rock)) {
        ship.health-=25;
        rocks.remove(rock);
        score-=25;
      }
      if (rock.reachedBottom()) {
        pass++;
        rocks.remove(rock);
      }
    }
    for (int i = 0; i < lasers.size(); i++) {
      Laser laser = lasers.get(i);
      laser.display();
      laser.fire();
      // Laser vs Rock collision
      for (int j = 0; j < rocks.size(); j++) {
        Rock rock = rocks.get(j);
        if (rock.laserIntersection(laser)) {
          rock.health-=25;
          lasers.remove(laser);
          if (rock.health<1) {
            rocks.remove(rock);
            score+=25;
          }
        }
      }

      for (int k = 0; k<enemies.size(); k++) {
        Enemy enemy = enemies.get(k);
        if (enemy.laserIntersect(laser)) {
          lasers.remove(laser);
          enemy.health-=20;
          if (enemy.health<1) {
            score+=enemy.healthStart;
            enemies.remove(enemy);
          }
        }
      }
      // dispose of lasers at top
      if (laser.reachedTop()) {
        lasers.remove(laser);
      }
    }

    if (puTimer.isFinished()) {
      pUps.add(new PowerUp(int(random(width)), -20));
      puTimer.start();
    }
    // PowerUp rendering and collision detection
    for (int i = 0; i<pUps.size(); i++) {
      PowerUp pu = pUps.get(i);
      pu.move();
      pu.display();
      // PowerUp and ship intersection
      if (ship.puIntersect(pu)) {
        // Apply PowerUp Effects
        if (pu.pu == 0) { // Adds ammo
          ship.ammo+=50;
        } else if (pu.pu == 1) { //Adds health
          ship.health+=100;
        } else if (pu.pu == 2) { //Adds lasers
          weaponCount++;
        } else if (pu.pu == 3) { //Adds super weapon
          superWeapon++;
        }
        pUps.remove(pu);
      }
      // dispose of rocks at bottom
      if (pu.reachedBottom()) {
        pUps.remove(pu);
      }
    }

    infoPanel();
    ship.display(mouseX, mouseY);

    if (ticker) {
      if (!ticTimer.isFinished()) {
        fill(255, 127);
        textSize(44);
        textAlign(CENTER);
        text(ticText, width/2, height/2);
      } else if (!ticTimer.isFinished() && ship.health < 30) {
        fill(255, 127);
        textSize(44);
        textAlign(CENTER);
        text(ticText, width/2, height/2);
      }
    }

    infoPanel();

    // GameOver Logic
    if (ship.health<1 || pass>100) {
      play = false;
      gameOver();
    }
  }
}

void mouseReleased() {
  if (mouseButton == RIGHT && superWeapon > 0) {  //super weapon
    superWeapon--;
    pass = 0;
    weaponCount = 1;
    enemyHealth = 100;
    rockRate = 1000;
    rockTimer.totalTime = rockRate;
    for (int i = 0; i<rocks.size(); i++) {
      Rock rock = rocks.get(i);
      score+=25;
      rocks.remove(rock);
      rockCount++;
    }
    rocks.removeAll(rocks);
    rockTimer.start();
    for (int i = 0; i<enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      score+=enemy.healthStart;
      enemies.remove(enemy);
      //enemy.start();
    }
    enemies.removeAll(enemies);
  }
  if (ship.ammo>0) {
    if (weaponCount == 1) {
      lasers.add(new Laser(ship.x, ship.y,#FEFF03));
      laserCount++;
      ship.ammo--;
    } else if (weaponCount == 2) {
      lasers.add(new Laser(ship.x-20, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x+20, ship.y,#FEFF03));
      laserCount++;
      ship.ammo-=2;
    } else if (weaponCount == 3) {
      lasers.add(new Laser(ship.x, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x-20, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x+20, ship.y,#FEFF03));
      laserCount++;
      ship.ammo-=3;
    } else if (weaponCount == 4) {
      lasers.add(new Laser(ship.x-20, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x+20, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x-40, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x+40, ship.y,#FEFF03));
      laserCount++;
      ship.ammo-=4;
    } else if (weaponCount == 5) {
      lasers.add(new Laser(ship.x, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x-20, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x+20, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x-40, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x+40, ship.y,#FEFF03));
      laserCount++;
      ship.ammo-=5;
    } else if (weaponCount == 6) {
      lasers.add(new Laser(ship.x-20, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x+20, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x-40, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x+40, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x-60, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x+60, ship.y,#FEFF03));
      laserCount++;
      ship.ammo-=6;
    } else if (weaponCount >= 7) {
      lasers.add(new Laser(ship.x, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x-20, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x+20, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x-40, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x+40, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x-60, ship.y,#FEFF03));
      lasers.add(new Laser(ship.x+60, ship.y,#FEFF03));
      laserCount++;
      ship.ammo-=7;
    }
  }
}

void keyPressed() {
  if (key == 'k' && superWeapon > 0) {  //super weapon
    superWeapon--;
    pass = 0;
    weaponCount = 1;
    enemyHealth = 100;
    rockRate = 1000;
    rockTimer.totalTime = rockRate;
    for (int i = 0; i<rocks.size(); i++) {
      Rock rock = rocks.get(i);
      score+=25;
      rocks.remove(rock);
      rockCount++;
    }
    rocks.removeAll(rocks);
    rockTimer.start();
    for (int i = 0; i<enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      score+=enemy.healthStart;
      enemies.remove(enemy);
      //enemy.start();
    }
    enemies.removeAll(enemies);
  }
  if (key == ' ') {
    if (ship.ammo>0) {
      if (weaponCount == 1) {
        lasers.add(new Laser(ship.x, ship.y,#FEFF03));
        laserCount++;
        ship.ammo--;
      } else if (weaponCount == 2) {
        lasers.add(new Laser(ship.x-20, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x+20, ship.y,#FEFF03));
        laserCount++;
        ship.ammo-=2;
      } else if (weaponCount == 3) {
        lasers.add(new Laser(ship.x, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x-20, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x+20, ship.y,#FEFF03));
        laserCount++;
        ship.ammo-=3;
      } else if (weaponCount == 4) {
        lasers.add(new Laser(ship.x-20, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x+20, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x-40, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x+40, ship.y,#FEFF03));
        laserCount++;
        ship.ammo-=4;
      } else if (weaponCount == 5) {
        lasers.add(new Laser(ship.x, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x-20, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x+20, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x-40, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x+40, ship.y,#FEFF03));
        laserCount++;
        ship.ammo-=5;
      } else if (weaponCount == 6) {
        lasers.add(new Laser(ship.x-20, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x+20, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x-40, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x+40, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x-60, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x+60, ship.y,#FEFF03));
        laserCount++;
        ship.ammo-=6;
      } else if (weaponCount >= 7) {
        lasers.add(new Laser(ship.x, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x-20, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x+20, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x-40, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x+40, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x-60, ship.y,#FEFF03));
        lasers.add(new Laser(ship.x+60, ship.y,#FEFF03));
        laserCount++;
        ship.ammo-=7;
      }
    }
  }
}

void ticker() {
  ticTimer.start();
  ticker = true;
  if (ticTimer.isFinished()) {
    ticker = false;
  }
}
void startScreen() {
  background(0);
  textAlign(CENTER);
  textSize(50);
  text("Welcome!", width/2, height/2);
  text("Click to Continue...", width/2, height/2+50);

  if (mousePressed) {
    play = true;
  }
}
void infoPanel() {
  fill(128, 128);
  textSize(10);
  rectMode(CORNER);
  rect(0, height-50, width, 50);
  fill(255, 128);
  text("Health:" + ship.health, 30, height-20);
  text("Ammo:" + ship.ammo, 100, height-20);
  text("Lives:" + ship.lives, 180, height-20);
  text("Score:" + score, 240, height-20);
}

void gameOver() {
  background(0);
  textSize(30);
  textAlign(CENTER);
  fill(222);
  text("Game Over!", width/2, height/2-20);
  text("Final Score:" + score, width/2, height/2+20);
  text("You made it to level " + level, width/2, height/2+60);
  noLoop();
}
