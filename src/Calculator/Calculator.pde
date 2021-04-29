Button[] numButtons = new Button[10];
Button[] opButtons = new Button[12];
String dVal;
String op ="";
boolean left = true;
float r = 0.0;
float l = 0.0;
float result = 0.0;
int currentNum = 0;
DivInfo di = new DivInfo(currentNum);

void setup() {
  size(360, 330);
  dVal = "0";
  numButtons[0] = new Button(40, 90, 40, 40, "0", #6993B3, #C9E8FF );
  numButtons[1] = new Button(90, 90, 40, 40, "1", #6993B3, #C9E8FF);
  numButtons[2] = new Button(140, 90, 40, 40, "2", #6993B3, #C9E8FF);
  numButtons[3] = new Button(190, 90, 40, 40, "3", #6993B3, #C9E8FF);
  numButtons[4] = new Button(240, 90, 40, 40, "4", #6993B3, #C9E8FF);
  numButtons[5] = new Button(290, 90, 40, 40, "5", #6993B3, #C9E8FF);
  numButtons[6] = new Button(40, 130, 40, 40, "6", #6993B3, #C9E8FF);
  numButtons[7] = new Button(100, 130, 40, 40, "7", #6993B3, #C9E8FF );
  numButtons[8] = new Button(160, 130, 40, 40, "8", #6993B3, #C9E8FF);
  numButtons[9] = new Button(220, 130, 40, 40, "9", #6993B3, #C9E8FF);
  opButtons[0] = new Button(280, 130, 40, 40, "C", #6993B3, #C9E8FF);
  opButtons[1] = new Button(40, 180, 40, 40, "+", #6993B3, #C9E8FF);
  opButtons[2] = new Button(40, 230, 40, 40, "x", #6993B3, #C9E8FF);
  opButtons[3] = new Button(100, 180, 40, 40, "-", #6993B3, #C9E8FF);
  opButtons[4] = new Button(100, 230, 40, 40, "÷", #6993B3, #C9E8FF);
  opButtons[5] = new Button(160, 180, 40, 40, ".", #6993B3, #C9E8FF);
  opButtons[6] = new Button(160, 230, 40, 40, "±", #6993B3, #C9E8FF);
  opButtons[7] = new Button(220, 180, 40, 40, "%", #6993B3, #C9E8FF);
  opButtons[8] = new Button(280, 180, 40, 40, "=", #6993B3, #C9E8FF);
  opButtons[9] = new Button(220, 230, 40, 40, "sin", #6993B3, #C9E8FF);
  opButtons[10] = new Button(280, 230, 40, 40, "cos", #6993B3, #C9E8FF);
  opButtons[11] = new Button(160, 270, 40, 40, "Rand", #6993B3, #C9E8FF );
}

void draw() {
  background(127);

  updateDisplay();

  for (int i=0; i<numButtons.length; i++) {
    numButtons[i].hover(mouseX, mouseY);
    numButtons[i].display();
  }
  for (int i=0; i<opButtons.length; i++) {
    opButtons[i].hover(mouseX, mouseY);
    opButtons[i].display();
  }
  callDivInfo();
}

void updateDisplay() {
  rectMode(CORNER);
  fill(80);
  rect(10, 10, width-20, 60);
  fill(255);
  textAlign(RIGHT);

  if (dVal.length()<13) {
    textSize(32);
  } else if (dVal.length()<14) {
    textSize(28);
  } else if (dVal.length()<15) {
    textSize(26);
  } else if (dVal.length()<17) {
    textSize(24);
  } else if (dVal.length()<19) {
    textSize(22);
  } else if (dVal.length()<21) {
    textSize(20);
  } else if (dVal.length()<23) {
    textSize(18);
  } else if (dVal.length()<25) {
    textSize(16);
  } else {
    textSize(14);
  }
  text(dVal, width-15, 50);

  fill(127);
  rectMode(CORNER);
  rect(10, 350, width-20, 60);

  textSize(9);
  textAlign(LEFT);
  fill(255);
  text("L:" + l + " R:" + r + " Op:" + op, 15, 350);
  text("Result:" + result + " Left:" + left, 15, 355);

  fill(127); 
  rectMode(CORNER);
  rect(10, 350, width-20, 180);

  textSize(9);
  textAlign(LEFT);
  fill(255);
  if (currentNum<34) {
    text("Factorial:" + di.factorial(currentNum), 15, 355);
  } else {
    text("Factorial too large to display!", 15, 290);
  }
  if (currentNum<10000000) {
    if (currentNum<1006 && currentNum>0) {
      text("This prime:" + di.primeList.get(currentNum), 15, 307);
    } else {
      text("This prime: too large", 15, 350);
    }
    text("Sum of Divisors:" + di.divSum(currentNum) + " or " + di.divSum2(currentNum), 15, 360);
    textLeading(10);
    text("Divisors:" + di.getDivs(currentNum), 15, 350, 250, 40);
  } else {
    text("Sum of Divisors: too large", 15, 319);
    textLeading(10);
    text("Divisors: too large", 15, 320, 250, 30);
  }
}


void mouseReleased() {
  for (int i=0; i<numButtons.length; i++) {
    if (numButtons[i].over && dVal.length()<20) {
      handleEvent(numButtons[i].val, true);
    }
  }
  for (int i=0; i<opButtons.length; i++) {
    if (opButtons[i].over) {
      handleEvent(opButtons[i].val, false);
    }
  }
}

void keyPressed() {
  println("KEY" + key + "keyCode:" + keyCode);

  if (key == '0') {
    handleEvent("0", true);
  } else if (key == '1') {
    handleEvent("1", true);
  } else if (key == '2') {
    handleEvent("2", true);
  } else if (key == '3') {
    handleEvent("3", true);
  } else if (key == '4') {
    handleEvent("4", true);
  } else if (key == '5') {
    handleEvent("5", true);
  } else if (key == '6') {
    handleEvent("6", true);
  } else if (key == '7') {
    handleEvent("7", true);
  } else if (key == '8') {
    handleEvent("8", true);
  } else if (key == '9') {
    handleEvent("9", true);
  } else if (key == '+') {
    handleEvent("+", false);
  } else if (key == '-') {
    handleEvent("-", false);
  } else if (key == '*') {
    handleEvent("x", false);
  } else if (key == '/') {
    handleEvent("÷", false);
  } else if (key == '.') {
    handleEvent(".", false);
  } else if (key == 'C') {
    handleEvent("C", false);
  } else if (key == 10) {
    if (keyCode == ENTER || keyCode == RETURN) {
      handleEvent("=", false);
    }
  } else if (keyCode == 27) {
    key = 0;
    if (key == 0) {
      handleEvent("C", false);
    }
  }
}

String handleEvent(String val, boolean num) {
  if (left & num) { // Left Number
    if (dVal.equals("0") || result == l) {
      dVal = (val);
      l = float(dVal);
    } else {
      dVal += (val);
      l = float(dVal);
    }
  } else if (!left && num) {
    if (dVal.equals("0") || result == l) {
      dVal = (val);
      r = float(dVal);
    } else { 
      dVal += (val);
      r = float(dVal);
    }
  } else if (val.equals("C")) {
    dVal = "0";
    result = 0.0;
    left = true;
    r = 0.0;
    l = 0.0;
    op = "";
  } else if (val.equals("+")) {
    if (!left) {
      performCalc();
    } else {
      op = "+";
      left = false;
      dVal = "0";
    }
  } else if (val.equals("-")) {
    op = "-";
    left = false;
    dVal = "0";
  } else if (val.equals("x")) {
    op = "x";
    left = false;
    dVal = "0";
  } else if (val.equals("÷")) {
    op = "÷";
    left = false;
    dVal = "0";
  } else if (val.equals("%")) {
    if (left) {
      l *= 0.1;
      dVal = str(l);
    } else {
      r *= 0.1;
      dVal = str(r);
    }
  } else if (val.equals("±")) {
    if (left) {
      l *= -1;
      dVal = str(l);
    } else {
      r *= -1;
      dVal = str(r);
    }
  } else if (val.equals("sin")) {
    if (left) {
      l = sin(radians(l));
      dVal = str(l);
    } else {
      r = sin(radians(r));
      dVal = str(r);
    }
  } else if (val.equals("cos")) {
    if (left) {
      l = cos(radians(l));
      dVal = str(l);
    } else {
      r = cos(radians(r));
      dVal = str(r);
    }
  } else if (val.equals("Rand")) {
    if (left) {
      l = random(0, 1);
      dVal = str(l);
    } else {
      r = random(0, 1);
      dVal = str(r);
    }
  } else if (val.equals(".") && !dVal.contains(".")) {
    dVal += (val);
  } else if (val.equals("=")) {
    performCalc();
  }
  return val;
}

void performCalc() {
  if (op.equals("+")) {
    result = l + r;
  } else if (op.equals("-")) {
    result = l - r;
  } else if (op.equals("x")) {
    result = l * r;
  } else if (op.equals("÷")) {
    result = l / r;
  }
  l = result;
  dVal = str(result);
  left = true;
}


void callDivInfo() {
  currentNum = int(dVal.replaceAll("\\.0*$", ""));
  if (!dVal.contains(".") || dVal.contains(".0")) {
    // Check for Prime
    if (currentNum < 1) {
      noFill();
      stroke(#BABACF);
      ellipse(20, 20, 15, 15);
      fill(#BABACF);
      text("p", 20, 25);
    } else {
      if (di.isPrime(currentNum)) {
        fill(#E3DBB6);
        noStroke();
        ellipse(20, 20, 15, 15);
        fill(0);
        text("p", 20, 25);
      } else {
        noFill();
        stroke(#BABACF);
        ellipse(20, 20, 15, 15);
        fill(#BABACF);
        text("p", 20, 25);
      }
    }

    // Check for Fib Number
    if (currentNum < 1) {
      noFill();
      stroke(#BABACF);
      ellipse(40, 20, 15, 15);
      fill(#BABACF);
      text("F", 40, 25);
    } else {
      if (di.isFibonacci(currentNum)) {
        fill(#E3DBB6);
        noStroke();
        ellipse(40, 20, 15, 15);
        fill(0);
        text("F", 40, 25);
      } else {
        noFill();
        stroke(#BABACF);
        ellipse(40, 20, 15, 15);
        fill(#BABACF);
        text("F", 40, 25);
      }
    }

    // Check for Catalan Number
    if (currentNum < 1) {
      noFill();
      stroke(#BABACF);
      ellipse(60, 20, 15, 15);
      fill(#BABACF);
      text("C", 60, 25);
    } else {
      if (di.isCatalan(currentNum)) {
        fill(#E3DBB6);
        noStroke();
        ellipse(60, 20, 15, 15);
        fill(0);
        text("C", 60, 25);
      } else {
        noFill();
        stroke(#BABACF);
        ellipse(60, 20, 15, 15);
        fill(#BABACF);
        text("C", 60, 25);
      }
    }

    // Check for Bell Number
    if (currentNum < 1) {
      noFill();
      stroke(#BABACF);
      ellipse(80, 20, 15, 15);
      fill(#BABACF);
      text("B", 80, 25);
    } else {
      if (di.isBell(currentNum)) {
        fill(#E3DBB6);
        noStroke();
        ellipse(80, 20, 15, 15);
        fill(0);
        text("B", 80, 25);
      } else {
        noFill();
        stroke(#BABACF);
        ellipse(80, 20, 15, 15);
        fill(#BABACF);
        text("B", 80, 25);
      }
    }

    // Check for Perfect Number
    if (currentNum < 1) {
      noFill();
      stroke(#BABACF);
      ellipse(100, 20, 15, 15);
      fill(#BABACF);
      text("P", 100, 25);
    } else {
      if (di.divSum(currentNum) == currentNum) {
        fill(#E3DBB6);
        noStroke();
        ellipse(100, 20, 15, 15);
        fill(0);
        text("P", 100, 25);
      } else {
        noFill();
        stroke(#BABACF);
        ellipse(100, 20, 15, 15);
        fill(#BABACF);
        text("P", 100, 25);
      }
    }
  } else {
    noFill();
    stroke(#BABACF);
    ellipse(20, 20, 15, 15);
    fill(#BABACF);
    text("P", 20, 25);
    noFill();
    stroke(#BABACF);
    ellipse(40, 20, 15, 15);
    fill(#BABACF);
    text("F", 40, 25);
    noFill();
    stroke(#BABACF);
    ellipse(60, 20, 15, 15);
    fill(#BABACF);
    text("C", 60, 25);
    noFill();
    stroke(#BABACF);
    ellipse(80, 20, 15, 15);
    fill(#BABACF);
    text("B", 80, 25);
  }
}
