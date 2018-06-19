void setup() { 


	size(640, 480);
	background(255);
	kochCurve(0, height/2, width, 5);
	//kochSnowFlake(width/4, height/2 - 100, width/2,5);

}

void draw() {

	noLoop();

}

void kochSnowFlake(float x, float y, float length, int depth) {

	pushMatrix();
	translate(x, y);
	pushMatrix();
	curve(depth, length);
	popMatrix();
	translate(length, 0);
	rotate(TWO_PI/3);
	pushMatrix();
	curve(depth, length);
	popMatrix();	
	translate(length, 0);
	rotate(TWO_PI/3);
	pushMatrix();
	curve(depth, length);
	popMatrix();
	popMatrix();

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

