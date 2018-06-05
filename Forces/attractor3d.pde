class Attractor {

  PVector position;
  float mass;

  Attractor(float x, float y, float z, float mass) {
  
    position = new PVector(x,y,z);
    this.mass = mass;
  
  }

  void draw() {
    pushMatrix();
    stroke(255);
    noFill();
    translate(position.x, position.y, position.z);
    sphere(20);
    popMatrix();
  
  }
}

class Mover {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  Mover(float x, float y, float z, float mass) {
    
    position = new PVector(x,y,z);
    velocity = new PVector(0,0,0);
    acceleration = new PVector(0,0,0);
    this.mass = mass;


  }

  void draw() {
    pushMatrix();
    stroke(255);
    noFill();
    translate(position.x, position.y, position.z);
    sphere(10);
    popMatrix();

  }

  void update() {

    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);

  }

  void applyForce(PVector force) {

    PVector f = force.get();
    f.div(mass);
    acceleration.add(f);


  }

}

PVector attraction(Attractor a, Mover m) {

  float G = 1;
  PVector force = PVector.sub(a.position, m.position);
  float distance = force.mag();
  distance = constrain(distance, 5.0, 25.0);
  force.normalize();
  float strength = (G * a.mass * m.mass)/(distance * distance);
  force.mult(strength);
  return force;


}

float angle = 0;
Mover m;
Attractor a;

void setup() {

  size(640, 480, P3D);
  m = new Mover(200,200, -10, 1);
  a = new Attractor(width/2, height/2, 0, 20);

}


void draw() {

  background(0);
  lights();
  translate(width/2, height/2, 0);
  rotateY(angle);
  translate(-width/2, -height/2, 0);
  m.draw();
  a.draw();

  PVector attraction = attraction(a,m);
  m.applyForce(attraction);
  m.update();
  angle += 0.01;


}
