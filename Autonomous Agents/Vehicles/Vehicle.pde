class Vehicle {

	PVector position;
	PVector velocity;
	PVector acceleration;
	float maxSpeed = 4;
	float maxForce = 0.1;

	Vehicle(float x, float y) {

		position = new PVector(x,y);
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);


	}

	void draw() {

		pushMatrix();
		translate(position.x, position.y);
		float angle = velocity.heading();
		rotate(angle);
		fill(175);
		stroke(0);
		triangle(-10, 10, 20, 0, -10, -10);
		popMatrix();
	}

	void update() {

		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0);

	}

	void applyForce(PVector force) {

		acceleration.add(force);

	}

	void seek(PVector target) {

		PVector desired = PVector.sub(target, position);
		//desired.mult(-1); //FLEEING BEHAVIOR
		desired.normalize();
		desired.mult(maxSpeed);
		PVector steering = PVector.sub(desired, velocity);
		steering.limit(maxForce);
		applyForce(steering);

	} 

}
