void setup() {
  size(400, 400);
}

void draw() {
  background(0);
  
  // draw months
  int w = 6;
  int h = 6;
  int count = 0;
  while (count < month()) {
    count++;

    fill(0, 150, 100);
    noStroke();
    ellipse(w, h, 10, 10);

    w += 11;
  }
  
  // draw days
  w = 6;
  h = 18;
  count = 0;
  while (count < day()) {
    count++;

    fill(0, 200, 150);
    noStroke();
    ellipse(w, h, 10, 10);

    w += 11;
  }

  // draw clock
  drawArc(0, 60, hour() % 24, 250, color(255, 50, 0));
  drawArc(0, 60, minute() % 60, 200, color(255, 100, 0));
  drawArc(0, 60, second() % 60, 150, color(255, 150, 0));
  drawArc(0, 1000, millis() % 1000, 100, color(255, 200, 0));

  // draw time text
  String timeText = hour() + ":" + minute() + ":" + second();

  textAlign(CENTER);
  textSize(12);
  fill(255);
  text(timeText, width/2, height/2);
}

private void drawArc(int min, int max, int val, int w, color c) {
  float deg = map(val, min, max/2, 0, PI);

  strokeWeight(8);
  noFill();
  stroke(c);
  arc(width/2, height/2, w, w, 0, deg);
}