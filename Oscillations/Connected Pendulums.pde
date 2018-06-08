class Pendulum {
	
	PVector anchor;
	PVector bob;
	float length;
	float angle;
	float aVelocity;

	Pendulum(float x, float y, float length, float angle) {
		
		anchor = new PVector(x,y);
		this.length = length;
		this.angle = angle;
		bob = new PVector((length * cos(angle)), (length * sin(angle)));

	}

	void draw() {

		translate(anchor.x, anchor.y);
		bob.x = length * cos(angle);
		bob.y = length * sin(angle);
		line(0, 0, bob.x, bob.y);
		ellipse(bob.x, bob.y, 25, 25);

	}

	void update() {

		float aAcceleration = G * sin(angle + PI/2)/length;
		aVelocity += aAcceleration;
		aVelocity *= 0.999;
		angle += aVelocity;



	}

	void connect(Pendulum p) {

		anchor.x = p.bob.x;
		anchor.y = p.bob.y;

	}
 
}

Pendulum p,p2,p3;
float G = 1;

void setup() {

	size(640, 360);
	p = new Pendulum(width/2, 10, 150, 0);
	p2 = new Pendulum(p.bob.x, p.bob.y, 100,PI/3);
	p3 = new Pendulum(p2.bob.x, p2.bob.y, 70, PI/6);

}

void draw() {

	background(255);
	p.draw();
	p.update();
	p2.connect(p);
	p2.draw();
	p2.update();
	p3.connect(p2);
	p3.update();
	p3.draw();

}
