import java.util.Random;

int[] numberList;

void setup() {
  size(400, 400);
  numberList = new int[width];
  
  // fill array with numbers from 0 to width of sceen
  for (int i = 0; i < numberList.length; i++) {
    numberList[i] = i;
  }
  
  // randomize array order
  shuffleArray(numberList);
  
  // show array
  showIntArray(numberList);
}

void draw() {
  frameRate(10000);
  bubblesort();
  showIntArray(numberList);
}

// bubble sort function
void bubblesort() {
  int l = numberList.length;
  Boolean swapped = true;

  while (swapped) {
    swapped = false;
    for (int i = 0; i < l; i++) {
      if (i-1 != -1 && numberList[i - 1] > numberList[i]) {
        int a = numberList[i-1];
        int b = numberList[i];
        numberList[i] = a;
        numberList[i - 1] = b;
        swapped = true;
        return; // <-- remove return to do instande sorting
      }
    }
  }
}

// array show and shuffel function

void showIntArray(int[] list) {
  loadPixels();
  // clear pixels
  for (int i = 0; i < pixels.length; i++) {
        pixels[i] = color(255, 255, 255);
  }
  
  // draw pixels
  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width; j++) {
      int index = (i*width) + j;
      if (j < list[i]) {
        pixels[index] = color(255, 0, 0);
      } else {
        break;
      }
    }
  }
  updatePixels();
}

void shuffleArray(int[] array) {
  Random rng = new Random();
 
  // i is the number of items remaining to be shuffled.
  for (int i = array.length; i > 1; i--) {
 
    // Pick a random element to swap with the i-th element.
    int j = rng.nextInt(i);  // 0 <= j <= i-1 (0-based array)
 
    // Swap array elements.
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}