

PVector start;
PVector end;



void setup() {

	size(640, 480);
	start = new PVector(10, height/3);
	end = new PVector(width - 10, height - 100);


}

void drawLine(PVector start, PVector end) {
	line(start.x, start.y, end.x, end.y);
	ellipse(start.x, start.y, 5, 5);
	ellipse(end.x, end.y, 5, 5);
}

void draw() {

	background(255);
	strokeWeight(2);
	fill(0);
	drawLine(start, end);
	PVector mousePos = new PVector(mouseX, mouseY);
	PVector a = PVector.sub(mousePos, start);
	PVector b = PVector.sub(end, start);


	float angle = PVector.angleBetween(a,b);
	float distance = a.mag() * cos(angle);
	b.normalize();
	b.mult(distance);
	PVector normalPoint = PVector.add(start, b);

	drawLine(start, mousePos);
	drawLine(mousePos, normalPoint);
	fill(0,255,0);
	ellipse(normalPoint.x, normalPoint.y, 7, 7);
  
}
