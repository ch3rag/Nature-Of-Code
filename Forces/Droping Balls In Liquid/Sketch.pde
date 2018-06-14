class Liquid {
	float x; 
	float y;
	float w;
	float h;
	float d; //Density
	float c; //Coef Of Drag

	Liquid(float x, float y, float w, float h, float c, float d) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.c = c;
		this.d = d;
	}

	void draw() {

		stroke(0);
		fill(175, 75);
		rect(x, y, w, h);

	}


}

class Mover {
	PVector position;
	PVector velocity;
	PVector acceleration;
	float mass;

	Mover(float x, float y, float mass) {

		position = new PVector(x,y);
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);
		this.mass = mass;

	}

	void draw() {

		stroke(0);
		fill(175);
		ellipse(position.x, position.y, mass * 16, mass * 16);

	}

	void checkEdges() {

		if(position.x <=  0) {
			position.x = 0;
			velocity.x *= -1;
		} else if(position.x >= width) {
			position.x = width;
			velocity.x *= -1;
		}

		if(position.y <=  0) {
			position.y = 0;
			velocity.y *= -1;
		} else if(position.y >= height) {
			position.y = height;
			velocity.y *= -1;
		}

	}

	boolean  isInside(Liquid l) {

		if(position.x > l.x && position.x < (l.x + l.w) && position.y > l.y && position.y < (l.y + l.h)) {
			return true;
		}

		return false;
	}

	void update() {

		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0);

	}

	void applyForce(PVector force) {

		PVector f = PVector.div(force, mass);
		acceleration.add(f);

	}

	void drag(Liquid l) {

		PVector dragForce = velocity.get();
		float v = velocity.mag();
		dragForce.normalize();
		dragForce.mult(l.c * l.d * v * v * -1);
		applyForce(dragForce);

	}
}

PVector wind = new PVector(5, -1);
Mover[] movers = new Mover[10];
float mu = 0.001;
float N = 1;
Liquid l;

void setup() {

	size(640, 660);

	l = new Liquid(0, height/2, width, height/2, 0.01, 1);
	int offset = width/(movers.length+1);
	for(int i = 0 ; i < movers.length ; i++) {
		movers[i] = new Mover(offset * (i + 1), 100, random(0.5,3));
	}
}

void mousePressed() {

	for(Mover m : movers) {

		m.applyForce(wind);
	
	}
}

void draw() {

	background(255);
	l.draw();
	
	for(int i = 0 ; i < movers.length ; i++) {

		movers[i].draw();
		PVector gravity = new PVector(0,0.1 * movers[i].mass);
		PVector friction = movers[i].velocity.get();
		friction.normalize();
		friction.mult(mu * N * -1);
		if(movers[i].isInside(l)) {

			movers[i].drag(l);

		}
		movers[i].applyForce(friction);
		movers[i].applyForce(gravity);
		movers[i].update();
		movers[i].checkEdges();

	}

}
