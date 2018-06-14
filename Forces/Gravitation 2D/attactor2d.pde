class Attractor {

	PVector position;
	float mass;

	Attractor(float x, float y, float mass) {
		
		position = new PVector(x,y);
		this.mass = mass;
	
	}

	void draw() {

		stroke(0);
		fill(175);
		ellipse(position.x, position.y, 25, 25);
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
		ellipse(position.x, position.y, 16, 16);

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


	void update() {

		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0);

	}

	void applyForce(PVector force) {

		PVector f = PVector.div(force, mass);
		acceleration.add(f);

	}

}



PVector attract(Attractor a, Mover m) {

	float G = 1;
	PVector force = PVector.sub(a.position, m.position);

	float distance = force.mag();
	distance = constrain(distance, 5.0, 25.0);
	force.normalize();
	float strength = (G * a.mass * m.mass)/(distance * distance);
 	force.mult(strength);
	return force;	

}

Attractor a;
Mover m;

void setup() {

	size(640, 360);
	a = new Attractor(width/2, height/2,20);
	m = new Mover(100,100,1);
	m.velocity.x = 1;

}


void draw() {

	background(0);
	
	a.draw();
	m.draw();
	m.update();
	PVector attraction = attract(a,m);
	m.applyForce(attraction);


}
