/*
Walker with the following probabilities:

chance of moving up: 20%

chance of moving down: 20%

chance of moving left: 20%

chance of moving right: 40%
/*


Walker w;

void setup() {
  size(640, 360);
  w = new Walker();
  background(255);
}

void draw() {
  w.display();
  w.step();
}

  
  
