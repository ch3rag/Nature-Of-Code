class Vehicle {

	PVector position;
	PVector velocity;
	PVector acceleration;
	float maxSpeed = 4;
	float maxForce = 0.2;


	Vehicle(float x, float y) {

		position = new PVector(x,y);
		velocity = new PVector(random(-1,1), random(-1,1));
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

		float predictionDistance = 50;

		PVector prediction = velocity.get();
		prediction.normalize();
		prediction.mult(predictionDistance);
		prediction.add(position);
	

		PVector leastNormalPoint = null;
		PVector target = null;
		float leastDistance = 99999;
		int x = 0;

		for(int i = 0 ; i < p.points.size() - 1 ; i++) {

			PVector a = p.points.get(i);
			PVector b = p.points.get(i+1);;
			PVector normalPoint = p.getNormalPoint(a, b, prediction);

			if(a.x > b.x) {
				normalPoint.x = constrain(normalPoint.x, b.x, a.x);
			} else {
				normalPoint.x = constrain(normalPoint.x, a.x, b.x);
			}

			if(a.y > b.y) {
				normalPoint.y = constrain(normalPoint.y, b.y, a.y);
			} else {
				normalPoint.y = constrain(normalPoint.y, a.y, b.y);
			}

			float distance = PVector.dist(normalPoint, prediction);

			if(distance < leastDistance) {
				leastDistance = distance;
				leastNormalPoint = normalPoint.get();
				x = i;
			}
		}
		float distance = PVector.dist(leastNormalPoint, prediction);
		target = PVector.sub(p.points.get(x+1),p.points.get(x));
		target.normalize();
		target.mult(30);
		target.add(leastNormalPoint);

		if(distance > p.radius) {
			seek(target);
		}
		drawFollowPathDebugData(prediction, leastNormalPoint, target); 
		//DRAWS DEBUG DATA
	}

	void drawFollowPathDebugData(PVector prediction, PVector leastNormalPoint, PVector target) {

		line(position.x, position.y, prediction.x, prediction.y);
		line(prediction.x,prediction.y, leastNormalPoint.x, leastNormalPoint.y);
		ellipse(prediction.x, prediction.y, 7, 7);
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
		if(desired.mag() == 0) return;
		desired.normalize();
		desired.mult(maxSpeed);
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

