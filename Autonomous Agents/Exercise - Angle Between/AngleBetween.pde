PVector v = PVector.fromAngle(0);


void setup() {

	size(640, 480);

}

float angleBetween(PVector v1, PVector v2) {


	float num = v1.x * v2.x + v1.y * v2.y;
	float denum = v1.mag() * v2.mag();
	float theta = acos(num/denum);
	return theta;

}

void drawVector(PVector v) {

	pushMatrix();
	rotate(v.heading());
	line(0,0,100,0);
	line(100,0,90,10);
	line(100,0,90,-10);
	popMatrix();
}


void draw() {

	background(255);
	stroke(0);
	pushMatrix();
	translate(width/2, height/2);
	PVector mousePos = new PVector(mouseX, mouseY);
	mousePos.sub(new PVector(width/2, height/2));
	mousePos.normalize();
	drawVector(v);
	drawVector(mousePos);
	popMatrix();
	fill(0,0,255);
	text("Angle (DEGREES) : " + angleBetween(mousePos, v), 10, height - 10);
	text("Angle (RADIANS) : " + degrees(angleBetween(mousePos, v)), 10, height - 20);
}
