int trainIndex = 0;
Perceptron p;
Point [] points = new Point[100];
void setup() {
 size(800, 800);
 p = new Perceptron(3);
 for(int i = 0 ; i < points.length ; i++) {
  points[i] = new Point(); 
 }
}

void draw() {
 background(255);
 stroke(0);
 Point p1 = new Point(-1, f(-1));
 Point p2 = new Point(1, f(1));
 line(p1.getX(), p1.getY(), p2.getX(), p2.getY());
 
 Point p3 = new Point(-1, p.guessY(-1));
 Point p4 = new Point(1, p.guessY(1));
 line(p3.getX(), p3.getY(), p4.getX(), p4.getY());
 
 for(Point pt : points) {
   pt.show();
   int target = pt.label;
   float [] inputs = {pt.x, pt.y, pt.bias};   
   int guess = p.guess(inputs);
   if(guess == target) {
    fill(0, 255, 0); 
   } else {
    fill(255, 0, 0); 
   }
   noStroke();
   ellipse(pt.getX(), pt.getY(), 16, 16);
 }
 
 Point pt = points[trainIndex];
 float [] inputs = {pt.x, pt.y, pt.bias};
 p.train(inputs, pt.label);
 trainIndex = (trainIndex + 1) % points.length;
}
