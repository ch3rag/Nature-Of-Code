class Vehicle {

	PVector position;
	PVector velocity;
	PVector acceleration;
	float maxSpeed = 4;
	float maxForce = 0.1;
	float wanderTheta = 0;

	Vehicle(float x, float y) {

		position = new PVector(x,y);
		velocity = new PVector(random(1,2), random(1,2));
		acceleration = new PVector(0,0);

	}

	void draw() {


		pushMatrix();
		fill(175);
		stroke(0);
		strokeWeight(2);
		translate(position.x, position.y);
		float angle = velocity.heading();
		rotate(angle);
		triangle(-5, 5, 10, 0, -5, -5);
		popMatrix();
	}


	void followPath(Path p) {

		float predictionDistance = 70;

		PVector prediction = velocity.get();
		prediction.normalize();
		prediction.mult(predictionDistance);
		prediction.add(position);
		

		PVector a = p.start;
		PVector b = p.end;

		PVector normalPoint = p.getNormalPoint(a, b, prediction);
		PVector target = PVector.sub(b,a);
		target.normalize();
		target.mult(30);
		target.add(normalPoint);

		float distance = PVector.dist(normalPoint, prediction);
		if(distance > p.radius) {
			seek(target);
		}

		//drawFollowPathDebugData(prediction, normalPoint, target);

	}

	void drawFollowPathDebugData(PVector prediction, PVector normalPoint, PVector target) {

		line(position.x, position.y, prediction.x, prediction.y);
		line(prediction.x, prediction.y, normalPoint.x, normalPoint.y);
		ellipse(prediction.x, prediction.y, 7, 7);
		ellipse(normalPoint.x, normalPoint.y, 5, 5);
		fill(0,255,0);
		ellipse(target.x, target.y, 10, 10);


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

}

