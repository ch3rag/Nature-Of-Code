void setup() { 


	size(640, 480);
	background(255);
	kochCurve(0, height/2, width, 5);

}

void draw() {

	noLoop();

}

void kochCurve(float x, float y, float length, int depth) {

	pushMatrix();
	translate(x, y);
	curve(depth, length);
	popMatrix();
}

void curve(int depth, float length) {

	if(depth == 0) {
		line(0,0,length,0);
		translate(length, 0);
	} else {

		curve(depth-1,length/3);
		rotate(-PI/3);
		curve(depth-1,length/3);
		rotate(TWO_PI/3);
		curve(depth-1,length/3);
		rotate(-PI/3);
		curve(depth-1,length/3);

	}

}

