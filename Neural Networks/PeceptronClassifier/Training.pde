float f(float x) {
 return -0.3 * x - 0.2; 
}

class Point {
  float x;
  float y;
  float bias;
  int label;
  Point() {
   bias = 1;
   x = random(-1, 1);
   y = random(-1, 1);
   float lineY = f(x);
   if(y > lineY) {
    label = 1;
   } else {
    label = -1; 
   }
  }
  
  Point(float x, float y) {
   this.x = x;
   this.y = y;
   bias = 1;
  }
  
  float getX() {
   return map(x, -1, 1, 0, width);
  }
  
  float getY() {
   return map(y, -1, 1, height, 0); 
  }
  
  void show() {
   stroke(0);
   if(label == 1) {
    fill(255); 
   } else {
    fill(0);
   }
  ellipse(getX(), getY(), 32, 32);
  }
}
