void setup() {

	size(640, 200);
	strokeWeight(1);
}

void draw() {

	cantor(10,10,width-20);
	noLoop();

}


void cantor(float x, float y, float length) {
	if(length <= 1) return;
	line(x, y, x + length, y);
	cantor(x, y+15, length/3);
	cantor(x+length - length/3, y + 15, length/3);


}
