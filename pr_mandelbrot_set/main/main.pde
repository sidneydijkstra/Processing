
int maxIt = 100;
float zoomX = 1;
float zoomY = 1;

float scale = 1.0f;
int lx = 0;
int ly = 0;

int xOffset = 0;
int yOffset = 0;



void setup() {
  size(400, 400);

  colorMode(HSB, 255);
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < width; y++) {

      float a = map(x + xOffset, lx, width - lx, -zoomX, zoomX);
      float b = map(y + yOffset, ly, height - ly, -zoomY, zoomY);

      float ca = (a/scale);
      float cb = (b/scale);

      int n = 0;

      while (n < maxIt) {
        float aa = a * a - b * b;
        float bb = 2 * a * b;

        a = aa + ca;
        b = bb + cb;

        if (abs(a + b) > 16) {
          break;
        }

        n++;
      }

      //float c = map(n, 0, maxIt, 0, 1);
      //c = map(sqrt(c), 0, 1, 0, 255);
      int c = (n * 16) % 255;

      if (n == maxIt) {
        c = 0;
      }

      int index = x + (y * width);
      pixels[index] = color(c, c, c);
    }
  }
  updatePixels();
  stroke(255);
  fill(0, 0, 0, 0);
  rect(mouseX - 100/2, mouseY - 100/2, 100, 100);
}

// zooming not working good yet
void keyPressed() {
  if (key == 'z') { // go out
    lx += 200;
    ly += 200;
    
    xOffset -= 100;
    yOffset += 100;
  }  if (key == 'x') { // go in
    lx -= 200;
    ly -= 200;
    
    xOffset += 0;
    yOffset -= 0;
  }  if (key == 'w' || key == 's') {
    yOffset += key == 'w' ? -30:30;
  }  if (key == 'a' || key == 'd') {
    xOffset += key == 'a' ? -30:30;
  }
}