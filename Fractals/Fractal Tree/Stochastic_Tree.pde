// CHIRAG SINGH RAJPUT
// Github.com/IamBharatSingh
// Simple Fractal Tree

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

	if(length < 10) return;

	line(0,0,0,-length);
	translate(0, -length);


    length *= 0.7;

    int numBranches = int(random(2,4));

    for(int i = 0 ; i < numBranches ; i++) {

	    float angle = random(-PI/3, PI/3);
		pushMatrix();
		rotate(angle);
		branch(length);
		popMatrix();

	}
}
