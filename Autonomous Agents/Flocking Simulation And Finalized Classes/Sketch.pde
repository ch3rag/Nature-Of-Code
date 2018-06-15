import controlP5.*; 

ControlP5 cp5;
ArrayList <Vehicle> vehicles = new ArrayList <Vehicle> ();

float seperation = 1.5;
float cohesion = 1;
float align = 1;

void setup() {

	size(800, 600);
	for(int i = 0; i < 300; i++) {
		vehicles.add(new Vehicle(width/2, height/2, 3, 0.05));
	}



	cp5 = new ControlP5(this);

	cp5.addSlider("seperation")
	   .setPosition(10,10)
	   .setSize(100,20)
	   .setRange(0,5);
	cp5.addSlider("cohesion")
	   .setPosition(10,40)
	   .setSize(100,20)
	   .setRange(0,5);
	cp5.addSlider("align")
	   .setPosition(10,70)
	   .setSize(100,20)
	   .setRange(0,5);

}


void draw() {

	background(0);
	for(Vehicle v : vehicles) {
		v.run();
		v.applyBehaviors(vehicles,seperation,cohesion,align);
	}

}
