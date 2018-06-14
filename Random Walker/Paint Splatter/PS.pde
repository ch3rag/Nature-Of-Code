import java.util.*;

class Splatter {
 
   int deviation;
   int numPoints;
   int col;
   Random generator; 
   
  Splatter(int deviation, int numPoints, color col) {
    
   this.deviation = deviation;
   this.numPoints = numPoints;
   this.col = col;
   this.generator = new Random();
  
  }
  
   void draw() {
      stroke(col);
      double num;
      for(int i = 0 ; i < numPoints ; i++) {
         num = generator.nextGaussian();
         double x = num * deviation + mouseX; 
         num = generator.nextGaussian();
         double y = num * deviation + mouseY;
         point((int)x,(int)y);
      }
   }
      
  
};

Splatter s;

void setup() {
 size(640, 360);
 s = new Splatter(5, 100, color(255,100,0,50)); 
}



void draw() {
 s.draw(); 
}
