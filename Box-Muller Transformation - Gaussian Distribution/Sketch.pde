
double getNextGaussian(double mu, double sigma) {
  float u1 = random(999)/1000;
  float u2 = random(999)/1000;
  double z = sqrt(-2 * log(u1)) *  cos(2 * PI * u2);
  return (z * sigma + mu);
}

int num = 60;

void setup() {
  size(600,400);  
}


void draw() {

 double randomNum = getNextGaussian(0,1);
 int x = (int)(randomNum * num + width/2);
 fill(0,10); 
 noStroke();
 ellipse(x,height/2,16,16);
  
}
