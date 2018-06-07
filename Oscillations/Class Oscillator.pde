class Oscillator {

	PVector amplitude;
	PVector angle;
	PVector velocity;

	Oscillator() {

		amplitude = new PVector(random(width/2), random(height/2));
		angle     = new PVector(0,0);
		velocity  = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
	}


	void update() {
		
		angle.add(velocity);

	}

	void draw() {
		stroke(255);
		float x = amplitude.x * sin(angle.x);
		float y = amplitude.y * sin(angle.y);
		pushMatrix();
			translate(width/2, height/2);
			line(0,0,x,y);
			ellipse(x,y,15,15);
		popMatrix();
	}

}

Oscillator[] osc;

void setup() {

	size(640, 360);
	osc = new Oscillator[20];
	for(int i = 0 ; i < osc.length ; i++) {
		osc[i] = new Oscillator();
	}

}

void draw() {

	background(0);
	for(Oscillator o : osc) {
		o.draw();
		o.update();
	}

}
