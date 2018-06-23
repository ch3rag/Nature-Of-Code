
void setup() {

	size(800,600);

}

void draw() {

	background(255);
	pushMatrix();
	translate(width/2, height);
	branch(150);
	popMatrix();

}


void branch(float length) {

	if(length < 2) return;

	line(0,0,0,-length);
	translate(0, -length);


    length *= 0.69;
    float angle = map(mouseX, 0, width, 0, TWO_PI);

	pushMatrix();
	rotate(-angle);
	branch(length);
	popMatrix();

	pushMatrix();
	rotate(angle);
	branch(length);
	popMatrix();

}
