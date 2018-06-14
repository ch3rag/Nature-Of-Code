int[] randomNums;
int arrayLength = 10;
int rectWidth;
void setup() {
  size(600, 400);
  randomNums =  new int[arrayLength];
  rectWidth = width / arrayLength;
}

void draw() {
  background(255);
  stroke(0);
  fill(175);
  int randomNum = int(random(arrayLength));
  randomNums[randomNum]++;
  for(int i = 0 ; i < randomNums.length ; i++) {
     rect(i * rectWidth, height, rectWidth - 1, -randomNums[i]);
  }
}
  
