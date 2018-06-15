Path p;
ArrayList <Vehicle> v = new ArrayList <Vehicle> ();

void setup() {

	size(640, 480);
	p = new Path();
}	

void draw() {

	background(255);
	if(mousePressed) {
		v.add(new Vehicle(mouseX, mouseY));
	}

	for(Vehicle v_ : v) {

		v_.followPath(p);
		v_.draw();
		v_.update();
		v_.wrapAround();
	}

	p.draw();


}
