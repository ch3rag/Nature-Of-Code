Path p;
ArrayList <Vehicle> v = new ArrayList <Vehicle> ();

void setup() {

	size(640, 480);
	p = new Path();
	p.addPoint(40,40);
	p.addPoint(width-40,40);
	p.addPoint(width-40,height-40);
	p.addPoint(40,height-40);
	p.addPoint(40,40);
	v.add(new Vehicle(width/2 - 100, height/2));
	v.add(new Vehicle(width/2 + 100, height/2));
	v.add(new Vehicle(width/2, height/2 + 100));
	v.add(new Vehicle(width/2, height/2 - 100));


}	

void draw() {

	background(255);
	p.draw();

	for(Vehicle v_ : v) {

		v_.followPath(p);
		v_.draw();
		v_.update();
	}
}
