Path p;
ArrayList <Vehicle> v = new ArrayList <Vehicle> ();

void setup() {

	size(640, 480);
	p = new Path();
	p.addPoint(60,60);
	p.addPoint(width/2 - 100, height/2 - 120);
	p.addPoint(width-60,60);
	p.addPoint(width-60,height-60);
	p.addPoint(width/2 + 100, height/2 + 120);
	p.addPoint(60,height-60);

}	

void draw() {

	background(255);
	p.draw();

	if(mousePressed) {
		v.add(new Vehicle(mouseX, mouseY));
	}

	for(Vehicle v_ : v) {

		v_.followPath(p);
		v_.draw();
		v_.update();
	}
}
