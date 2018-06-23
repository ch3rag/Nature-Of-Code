// CHIRAG SINGH RAJPUT
// Github.com/IamBharatSingh
// Fractal Tree With Varying StrokeWidth

float angle = PI/3;

void setup() {

	size(800,600);

}

void draw() {

	background(255);
	pushMatrix();
	translate(width/2, height);
	branch(150);
	popMatrix();
	noLoop();

}


void branch(float length) {

	if(length < 2) return;
	strokeWeight(length/10);
	stroke(0,150);
	line(0,0,0,-length);
	translate(0, -length);


    length *= 0.6;

	pushMatrix();
	rotate(-angle);
	branch(length);
	popMatrix();

	pushMatrix();
	rotate(angle);
	branch(length);
	popMatrix();

	pushMatrix();
	rotate(-angle/2);
	branch(length);
	popMatrix();

	pushMatrix();
	rotate(angle/2);
	branch(length);
	popMatrix();

}
