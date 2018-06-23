// CHIRAG SINGH RAJPUT
// Github.com/IamBharatSingh
// Seirspinski Triangle

void setup() {

	size(800, 700);
	background(255);
	colorMode(HSB);
	noStroke();
	fill(150,170,255);

}


void draw() {

	seirspinski(width/2, 0, 800,8);
	noLoop();
}
// (x,y)  = coordinate of top vertex
// length = length of the side

void seirspinski(float x, float y, float length, int depth) {

	if(depth == 1) {

		float py = sqrt(3)*length/2;
		float px = length/2; 
		triangle(x, y, x - px, y + py, x + px, y + py);
		return;

	}

	seirspinski(x,y, length/2, depth-1);
	seirspinski(x + length/2 * cos(TWO_PI/3), y + length/2 * sin(TWO_PI/3), length/2, depth-1);
	seirspinski(x - length/2 * cos(TWO_PI/3), y + length/2 * sin(TWO_PI/3), length/2, depth-1);

}
