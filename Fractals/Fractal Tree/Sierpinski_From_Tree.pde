
float x = 0;
void setup() {

  size(800,600);

}

void draw() {

  background(255);
  pushMatrix();
  translate(width/2, height/2 + 70);
  branch(150, 6);
  popMatrix();
  x += 0.01;
}



void branch(float length, float  depth) {

  float angle = sin(x) * TWO_PI/3;

  if (depth < 0) return;

    line(0,0,0,-length);
    pushMatrix();
    rotate(-angle);
    line(0,0,0,-length);
    popMatrix();
    pushMatrix();
    rotate(angle);
    line(0,0,0,-length);
    popMatrix(); 

    

    pushMatrix();
    rotate(-angle);
    translate(0,-length);
    branch(length*0.5, depth - 1);
    popMatrix();

    pushMatrix();
    rotate(angle);
    translate(0,-length);
    branch(length*0.5, depth - 1);
    popMatrix();

    pushMatrix();
    translate(0,-length);
    branch(length*0.5, depth - 1);
    popMatrix();


}
