Vehicle v;
ImageFlowField f;
PImage face;

void setup() { 
	
	size(500, 500);
	
	face = loadImage("/data/face.jpg");		
	v = new Vehicle(width/2, height/2);
	f = new ImageFlowField(20,face);
}

void draw() {

	background(255);

		v.followFlowField(f);
		v.update();
		v.wrapAround();
		f.draw();
		v.draw();
}

