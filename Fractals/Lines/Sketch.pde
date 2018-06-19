void setup() {

	size(640, 480);
	strokeWeight(1);
}

void draw() {

	drawLine(width/2, height/2, width/3);
	noLoop();

}


void drawLine(float x, float y, float length) {
	if(length < 2) return;
	line(x,y,x + length, y);
	line(x,y,x-length, y);
	line(x+length,y,x + length, y+length/2);
	line(x+length,y,x + length, y-length/2);
	line(x-length,y,x - length, y+length/2);
	line(x-length,y,x - length, y-length/2);
	 drawLine(x-length, y-length/2,length/3);
	 drawLine(x+length, y-length/2,length/3);
	 drawLine(x-length, y+length/2,length/3);
	 drawLine(x+length, y+length/2,length/3);

}
