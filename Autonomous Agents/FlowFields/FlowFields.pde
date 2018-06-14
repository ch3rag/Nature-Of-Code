Vehicle v;
FlowField f;

void setup() { 
	
	size(640, 480);
  
		v = new Vehicle(width/2, height/2);
		f = new FlowField(20);
}

void draw() {

	background(255);

		v.followFlowField(f);
		v.update();
		v.wrapAround();
		v.draw();
		f.draw();
		f.updateFlowField();
}

