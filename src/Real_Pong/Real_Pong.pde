Ball ball; 

Paddle paddleLeft;
Paddle paddleRight;

int scoreLeft = 0;
int scoreRight = 0;
boolean play;

void setup() {
  size(800, 600);
  ball = new Ball(width/2, height/2, 25); 
  ball.speedX = 8; 
  ball.speedY = 8; 

  paddleLeft = new Paddle(75, height/2, 30, 200);
  paddleRight = new Paddle(width-75, height/2, 30, 200);
  play = false;
}

void draw() {
  if (!play) {
    startScreen();
  } else {
    background(0); 
    ball.display(); 
    ball.move(); 
    ball.display(); 

    paddleLeft.move();
    paddleLeft.display();
    paddleRight.move();
    paddleRight.display();
    fill(#0300FF);
    stroke(255);
    line(400, 0, 400, 600);    
    ellipse(400, 300, 75, 75);
    line(780, 600, 780, 0);
    line(20, 600, 20, 0);
    line(700, 450, 700, 150);
    line(700, 450, 780, 450);
    line(700, 150, 780, 150);
    line(100, 450, 100, 150);
    line(100, 450, 20, 450);
    line(100, 150, 20, 150);

      if (ball.right() > 780) {
        scoreLeft = scoreLeft + 1;
        ball.x = width/2;
        ball.y = height/2;
      }
      if (ball.left() < 20) {
        scoreRight = scoreRight + 1;
        ball.x = width/2;
        ball.y = height/2;
      }
      if (ball.bottom() > height) {
        ball.speedY = -ball.speedY;
      }

      if (ball.top() < 0) {
        ball.speedY = -ball.speedY;
      }

      if (paddleLeft.bottom() > height) {
        paddleLeft.y = height-paddleLeft.h/2;
      }

      if (paddleLeft.top() < 0) {
        paddleLeft.y = paddleLeft.h/2;
      }

      if (paddleRight.bottom() > height) {
        paddleRight.y = height-paddleRight.h/2;
      }

      if (paddleRight.top() < 0) {
        paddleRight.y = paddleRight.h/2;
      }

      if ( ball.left() < paddleLeft.right() && ball.y > paddleLeft.top() && ball.y < paddleLeft.bottom()) {
        ball.speedX = -ball.speedX;
        ball.speedY = map(ball.y - paddleLeft.y, -paddleLeft.h/2, paddleLeft.h/2, -10, 10);
      }

      if ( ball.right() > paddleRight.left() && ball.y > paddleRight.top() && ball.y < paddleRight.bottom()) {
        ball.speedX = -ball.speedX;
        ball.speedY = map(ball.y - paddleRight.y, -paddleRight.h/2, paddleRight.h/2, -10, 10);
      }
      textSize(40);
      textAlign(CENTER);
      fill(#001BFF);
      text(scoreRight, width/2+30, 30); 
      text(scoreLeft, width/2-30, 30); 
    }
  }
  void keyPressed() {
    if (keyCode == UP) {
      paddleRight.speedY=-10;
    }
    if (keyCode == DOWN) {
      paddleRight.speedY=10;
    }
    if (key == 'a') {
      paddleLeft.speedY=-10;
    }
    if (key == 'z') {
      paddleLeft.speedY=10;
    }
  }

  void keyReleased() {
    if (keyCode == UP) {
      paddleRight.speedY=0;
    }
    if (keyCode == DOWN) {
      paddleRight.speedY=0;
    }
    if (key == 'a') {
      paddleLeft.speedY=0;
    }
    if (key == 'z') {
      paddleLeft.speedY=0;
    }
  }

  void startScreen() {
    background(0);
    textAlign(CENTER);
    text("Up and down arrow keys control right paddle", width/2, height/2);
    text("A and Z control left padde", width/2, height/2+20);
    text("Click to continue", width/2, height/2+40);

    if (mousePressed) {
      play = true;
    }
  }
