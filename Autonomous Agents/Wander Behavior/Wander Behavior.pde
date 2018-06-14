

Vehicle v;

void setup() { 
	
	size(640, 480);
	
		v = new Vehicle(width/2, height/2);
}

void draw() {

	background(255);

		//v.seek(new PVector(mouseX, mouseY));
		v.wander();
		v.update();
		v.draw();
}

