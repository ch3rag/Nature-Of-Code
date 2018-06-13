

Vehicle[] v = new Vehicle[10];

void setup() { 
	
	size(640, 480);
	
	for(int i = 0 ; i < v.length ; i++) {
		v[i] = new Vehicle(random(width), random(height));
	}
}

void draw() {

	background(255);
	for(Vehicle v_ : v) {
		v_.draw();
		v_.seek(new PVector(mouseX, mouseY));
		v_.update();
	}


}
