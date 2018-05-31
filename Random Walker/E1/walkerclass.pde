
class Walker {
  int x;
  int y;

  Walker() {
    x = width/2;
    y = height/2;
    
  }
  
  void step() { 
    
    float randomNum = random(1);
    if(randomNum < 0.4) {
      x++;
    } else if(randomNum < 0.6) {
      x--;
    } else if(randomNum < 0.8) {
      y--;
    } else {
      y++;
    }
  }
  
  void display() {
    stroke(0);
    point(x,y);
  }
};
  
