class Element {
		
	PVector position;
	PVector acceleration;
	PVector velocity;
	float radius;	
	float maxForce = 0.05;
	float maxSpeed = 2;
	float maxRad;
	float minRad;


	Element(float x, float y, float min, float max) {

		minRad = min;
		maxRad = max;
		this.radius = random(minRad, maxRad);;
		position = new PVector(x,y);
		velocity = new PVector(random(-2,2), random(-2,2));
		acceleration = new PVector(0,0);
	
	}

	void applyBehavior(ArrayList <Element> elements) {

		// FOR PROCESS 4

		PVector stayWithinWallsForce = stayWithinWalls(20);
		changeDirection(elements);
		PVector seperateForce = seperate(elements);
		seperateForce.mult(1);
		applyForce(seperateForce);
		applyForce(stayWithinWallsForce);

		// FOR PROCESS 10

		
		// changeDirection(elements);
		// PVector seperateForce = seperate(elements);
		// seperateForce.mult(1);
		// applyForce(seperateForce);
		// reset();

		
		

	}

	void draw() {

		stroke(255);
		noFill();
		strokeWeight(1);
		ellipse(position.x, position.y, radius * 2, radius * 2);
		debugDraw();
	}

	void drawProcess(Element e, float distance) {

		float s = map(distance,minRad*2,maxRad*2,0,255);
		stroke(230,s,s,15);
		strokeWeight(2);
		line(position.x, position.y, e.position.x, e.position.y);


	}


	void debugDraw() {

		pushMatrix();
		translate(position.x, position.y);
		rotate(velocity.heading());
		line(0,0,radius,0);
		line(radius,0, radius * 0.7, radius/4);
		line(radius,0, radius * 0.7, -radius/4);
		popMatrix();

	}

	void applyForce(PVector force) {
		acceleration.add(force);
	}

	void update() {

		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0);

	}

	void run() {

		//draw();
		update();

	}

	PVector stayWithinWalls(float radius) {

		PVector desired = null;

		//stayWithinWallsDebug(radius);	

		if(position.x < radius) {
			desired = new PVector(maxSpeed, velocity.y);
		} else if(position.x > width - radius) {
			desired = new PVector(-maxSpeed, velocity.y);
		}


		if(position.y < radius) {
			desired = new PVector(velocity.x, maxSpeed);
		} else if(position.y > height - radius) {
			desired = new PVector(velocity.x, -maxSpeed);
		}
	

		if(desired != null) {
			PVector steer = PVector.sub(desired, velocity);
			steer.limit(maxForce);
			return steer;
		} else return new PVector(0,0);

		
	}

	void stayWithinWallsDebug(float radius) {
		noFill();
		stroke(255,100);
		rect(radius,radius, width - radius * 2, height - radius * 2);
	}

	void changeDirection(ArrayList <Element> elements) {


		float aVel = 0.005;
		for(Element e : elements) {
			float distance = PVector.dist(position, e.position);
			if(distance > 0 && distance < (radius + e.radius)) {
				velocity.rotate(aVel);
				drawProcess(e,distance);
			}
		}

	}

	PVector seperate(ArrayList <Element> elements) {

		PVector average = new PVector(0,0);
		int count = 0;
		for(Element e : elements) {
			float distance = PVector.dist(position, e.position);
			if(distance > 0 && distance < (radius + e.radius)) {
				PVector dir = PVector.sub(position, e.position);
				dir.normalize();
				dir.div(distance);
				average.add(dir);
				count++;
			}
		}

		if(count > 0) {

			average.setMag(maxSpeed);
			PVector steer = PVector.sub(average, velocity);
			steer.limit(maxForce);
			return steer;
		} 
		return average;
	}

	void reset() {
		if(position.x > width || position.x < 0 || position.y > height || position.y < 0) {
			position.x = width/2;
			position.y = height/2;
		}
	}

}
