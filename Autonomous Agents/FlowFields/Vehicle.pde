class Vehicle {

	PVector position;
	PVector velocity;
	PVector acceleration;
	float maxSpeed = 4;
	float maxForce = 0.1;
	float wanderTheta = 0;

	Vehicle(float x, float y) {

		position = new PVector(x,y);
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);

	}

	void draw() {


		pushMatrix();
		fill(175);
		stroke(0);
		translate(position.x, position.y);
		float angle = velocity.heading();
		rotate(angle);
		triangle(-10, 10, 20, 0, -10, -10);
		popMatrix();
	}

	void wander() {
		
		float distance = 80;
		float radius = 25;
		float change = 0.3;
		wanderTheta += random(-change, change);
		


		PVector circlePosition = velocity.get();
		circlePosition.normalize();
		circlePosition.mult(distance);
		circlePosition.add(position);

		float angle = velocity.heading();
		PVector circleOffset = new PVector(radius * cos(angle + wanderTheta), radius * sin(angle + wanderTheta));
		PVector target = PVector.add(circlePosition, circleOffset);
		seek(target);

		//drawWanderDebugData(circlePosition, radius, target); //DRAWS DEBUG DATA



	}

	void followFlowField(FlowField f) {

		PVector desired = f.lookup(position);
		desired.mult(maxSpeed);
		PVector steering = PVector.sub(desired, velocity);
		steering.limit(maxForce);
		applyForce(steering);

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
		float dis = desired.mag();
		desired.normalize();
				if(dis < 100) {
			float m = map(dis, 0,  100, 0, maxSpeed);
			desired.mult(m);
		} else {
			desired.mult(maxSpeed);
		}
		PVector steering = PVector.sub(desired, velocity);
		steering.limit(maxForce);
		applyForce(steering);
	} 

	void wrapAround() {

		if(position.x > width) {
			position.x = 0;
		} else if(position.x < 0) {
			position.x = width;
		}

		if(position.y > height) {
			position.y = 0;
		} else if(position.y < 0) {
			position.y = height;
		}

	}

	void stayWithinWalls() {

		float edgeDistance = 24;
		PVector desired = new PVector(0,0);

		drawStayWithinWallsDebugData(edgeDistance);
		
		if(position.x > width - edgeDistance ) {
			desired = new PVector(-maxSpeed, velocity.y);
			PVector steering = PVector.sub(desired, velocity);
			steering.limit(maxForce);
 			applyForce(steering);

		} else if(position.x < edgeDistance) {
			desired = new PVector(maxSpeed, velocity.y);
			PVector steering = PVector.sub(desired, velocity);
			steering.limit(maxForce);
 			applyForce(steering);

		}

		if(position.y > height - edgeDistance) {
			desired = new PVector(velocity.x, -maxSpeed);
			PVector steering = PVector.sub(desired, velocity);
			steering.limit(maxForce);
 			applyForce(steering);
		} else if(position.y < edgeDistance) {
			desired = new PVector(velocity.x, maxSpeed);
			PVector steering = PVector.sub(desired, velocity);
			steering.limit(maxForce);
 			applyForce(steering);
		}

	}


	void drawWanderDebugData (PVector circlePosition, float radius, PVector target) {

		pushMatrix();
		stroke(0);
		strokeWeight(2);
		line(position.x, position.y, circlePosition.x, circlePosition.y);
		ellipse(circlePosition.x, circlePosition.y, radius*2, radius*2);
		line(circlePosition.x, circlePosition.y, target.x, target.y);
		fill(0);
		ellipse(target.x, target.y, 5, 5);
		popMatrix();


	}

	void drawStayWithinWallsDebugData(float edge) {
		noFill();
		rect(edge,edge,width - edge * 2, height - edge * 2);

	}	
}

