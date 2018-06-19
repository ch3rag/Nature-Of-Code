void setup() {
	size(800,800);
	noFill();
}


void draw() {

	drawCircle(width/2, height/2 , 300);
	noLoop();
	noFill();
}

void drawCircle(float x, float y, float radius) {

	if(radius < 3) {
		return;
	} else {
		ellipse(x, y, radius, radius);
		drawCircle(x - radius/2, y, radius/2);
		drawCircle(x + radius/2, y, radius/2);	
		drawCircle(x, y + radius/2, radius/2);
		drawCircle(x, - radius/2 + y, radius/2);
		
	}

}
