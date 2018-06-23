// CHIRAG SINGH RAJPUT
// Github.com/IamBharatSingh
// Seirspinski Triangle (Arrow Head Curve)

void setup() {
	
	size(800, 800);
	strokeWeight(3);


}

void draw() {
	background(255);
	sierspinski(0, height-100, width, 7);
	noLoop();
}

void sierspinski(float x, float y, float length, int depth) {

	pushMatrix();
	translate(x, y);
	
	if(depth % 2 == 0) {
		drawLines(length, depth, -PI/3);
	} else {
		rotate(-PI/3);
		drawLines(length, depth, PI/3);
	}

	popMatrix();

}
void drawLines(float length, int depth, float angle) {

	if(depth == 0) {
		line(0,0,length,0);
		translate(length, 0);

	} else {

		drawLines(length/2, depth - 1,- angle);
		rotate(angle);
		drawLines(length/2, depth - 1,+ angle);
		rotate(angle);
		drawLines(length/2, depth - 1,- angle);
	}
}
