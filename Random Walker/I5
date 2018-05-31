// Exercise I5
// Random Walker in which step size is the function of guassian distribution


import java.util.*;

class Walker {
 
   int x;
   int y;
   int px;
   int py;
   int stepSize;
   Random generator; 
   
  Walker(int stepSize) {
   this.px = this.x = width/2;
   this.py = this.y = height/2;
   this.stepSize = stepSize;
   this.generator = new Random();
  }
  
  void step() {
    px = x;
    py = y;
    double num = generator.nextGaussian();
    double stepX = num * stepSize;  
    num = generator.nextGaussian();
    double stepY = num * stepSize;
    y += (int)stepX;
    x += (int)stepY; 
  }
  
   void display() {
         stroke(0);
         line(px,py,x,y);
   }
      
  
};

Walker w;

void setup() {
 size(640, 360);
 w = new Walker(10); 
}



void draw() {
  
 w.display();
 w.step();
 
}
