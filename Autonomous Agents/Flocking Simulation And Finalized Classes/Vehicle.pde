// MASTER BOIDS CLASS
/*
	IMLEMENTED BEHAVIORS

	- SEEK
	- ARRIVE
	- FOLLOW PATH
	- WANDER
	- FOLLOW FLOWFIELD
	- STAY WITHIN A BOUNDARY
	- SEPERATE
	- ALIGN
	- COHESION


*/

class Vehicle {

	PVector position;
	PVector velocity;
	PVector acceleration;
	float maxSpeed;
	float maxForce;
	float wanderTheta = 0; //TO BE USED WHILE WANDER

	Vehicle(float x, float y, float maxSpeed, float maxForce) {
		this.maxForce = maxForce;
		this.maxSpeed = maxSpeed;
		position = new PVector(x,y);
		velocity = new PVector(random(-1, 1), random(-1, 1));
		acceleration = new PVector(0,0);

	}

	void applyBehaviors(ArrayList <Vehicle> vehicles, float magSep, float magCoh, float magAli) { 

	//THIS FUNCTION IS USED TO ADD OR REMOVE A BEHVIOUR FROM BOIDS
	//CHANGE PARAMETERS AS REQUIRED

	//Examples Of How You Might Use Behaviors

	//PVector seekForce = seek(TARGET VECTOR);
	//PVector arriveForce = arrive(TARGET VECTOR);
	//PVector followPathForce = followPath(TARGET PATH);
	//PVector wanderForce = wander();
	//PVector followFlowFieldForce = followFlowField(TARGET FLOW FIELD);
	//PVector stayWithinWallsForce = stayWithinWalls(EDGE DISTANCE);
	//USE APPLYFORCE(FORCE) FOR EACH OF ABOVE BEHAVIOR

	//PVector seekForce = seek(new PVector(mouseX, mouseY));
	// PVector arriveForce = arrive(new PVector(mouseX, mouseY));
	// applyForce(arriveForce);

	//PVector wanderForce = wander();		
	// PVector stayWithinWallsForce = stayWithinWalls(20);
	// wanderForce.mult(1);
	// stayWithinWallsForce.mult(3); 
	// WEIGHTS TO PROMOTE A SPECIFIC BEHAVIOUR
	// applyForce(stayWithinWallsForce);


	PVector seperateForce = seperate(vehicles);
	PVector alignForce = align(vehicles);
	PVector cohesionForce = cohesion(vehicles);
	alignForce.mult(magAli);
	seperateForce.mult(magSep);
	cohesionForce.mult(magCoh);
	applyForce(seperateForce);
	applyForce(alignForce);
	applyForce(cohesionForce);



	}

	void draw() {

		pushMatrix();
		fill(175);
		stroke(0);
		strokeWeight(1);
		translate(position.x, position.y);
		float angle = velocity.heading();
		rotate(angle);
		triangle(-3, 3, 8, 0, -3, -3);
		popMatrix();

	}



	void run() {

		draw();
		update();
		wrapAround();
		//IF ENABLE WARPAROUND
	}


	PVector align(ArrayList <Vehicle> vehicles) {
		float lookupRadius = 50;
		int count = 0;
		PVector average = new PVector();
		for(Vehicle v : vehicles) {
			float distance = PVector.dist(position, v.position);
			if(distance < lookupRadius && distance > 0) {
				average.add(v.velocity);
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

	PVector cohesion(ArrayList <Vehicle> vehicles) {

		float lookupRadius = 50;
		int count = 0;
		PVector average = new PVector();
		for(Vehicle v : vehicles) {
			float distance = PVector.dist(position, v.position);
			if(distance > 0 && distance < lookupRadius) {
				average.add(v.position);
				count++;
			}
		}

		if(count > 0) {
			average.div(count);
			return seek(average);
		} 

		return average;
	}

	PVector followPath(Path p) {

		float predictionDistance = 20;

		PVector prediction = velocity.get();
		prediction.normalize();
		prediction.mult(predictionDistance);
		prediction.add(position);
	

		PVector leastNormalPoint = null;
		PVector targetDir = null;
		float leastDistance = 999999;
		int x = 0;

		for(int i = 0 ; i < p.points.size(); i++) {

			PVector a = p.points.get(i);
			PVector b = p.points.get((i+1) % p.points.size());

			PVector normalPoint = p.getNormalPoint(a, b, prediction);
			

			if(normalPoint.x < min(a.x, b.x) || normalPoint.x > max(a.x, b.x) || normalPoint.y < min(a.y, b.y) || normalPoint.y > max(a.y,b.y)) {

				normalPoint = b.get();
				a = p.points.get((i + 1) % p.points.size());
				b = p.points.get((i + 2) % p.points.size());
			}

			PVector dir = PVector.sub(b,a);
			float distance = PVector.dist(normalPoint, prediction);

			if(distance < leastDistance) {
				leastDistance = distance;
				leastNormalPoint = normalPoint.get();
				targetDir = dir.get();
			}
		}

		targetDir.normalize();
		targetDir.mult(30);
		targetDir.add(leastNormalPoint);

		if(leastDistance > p.radius) {
			return seek(targetDir); //RETURNS STEERING FORCE
		} else {
			velocity.setMag(maxSpeed); //(IT'S ON THE PATH!) FOLLOW THE PATH WITH MAXIMUM SPEED
		}

		return new PVector(0, 0);

		//drawFollowPathDebugData(prediction, leastNormalPoint, targetDir); 
		//DRAWS DEBUG DATA
	}

	PVector seperate(ArrayList <Vehicle> vehicles) {

		float seperationRadius = 25;
		PVector sum = new PVector();
		int count = 0;
		for(Vehicle v : vehicles) {
			PVector force = PVector.sub(position, v.position);
			float distance = force.mag();
			if((distance > 0) && (distance < seperationRadius)) {
				force.normalize();
				force.div(distance);
				sum.add(force);
				count++;
			}
		}

		if(count > 0) {
			sum.setMag(maxSpeed);
			PVector steer = PVector.sub(sum, velocity);
			steer.limit(maxForce);
			return steer;
		}

		return sum;
	}	

	void drawFollowPathDebugData(PVector prediction, PVector leastNormalPoint, PVector target) {

		line(position.x, position.y, prediction.x, prediction.y);
		line(prediction.x,prediction.y, leastNormalPoint.x, leastNormalPoint.y);
		ellipse(prediction.x, prediction.y, 7, 7);
		fill(0,255,0);
		ellipse(target.x, target.y, 10, 10);


	}

	PVector followFlowField(FlowField f) {

		PVector desired = f.lookup(position);
		desired.mult(maxSpeed);
		PVector steering = PVector.sub(desired, velocity);
		steering.limit(maxForce);
		return steering;

	}
 
	void update() {

		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0);
	}

	void applyForce(PVector force) {

		acceleration.add(force);

	}

	PVector seek(PVector target) {

		PVector desired = PVector.sub(target, position);
		desired.normalize();
		desired.mult(maxSpeed);
		PVector steering = PVector.sub(desired, velocity);
		steering.limit(maxForce);
		return steering;
	} 

	PVector arrive(PVector target) {

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
		return steering;
	} 

	PVector wander() {
		
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
		return seek(target); //RETURNS STEERING FORCE

		//drawWanderDebugData(circlePosition, radius, target); //DRAWS DEBUG DATA

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

	void drawStayWithinWallsDebugData(float edge) {
		noFill();
		rect(edge,edge,width - edge * 2, height - edge * 2);

	}	


PVector stayWithinWalls(float edgeDistance) {

		PVector desired = null;
		PVector steering = null;

		drawStayWithinWallsDebugData(edgeDistance);
		
		
		if(position.x > width - edgeDistance ) {
			desired = new PVector(-maxSpeed, velocity.y);
		} else if(position.x < edgeDistance) {
			desired = new PVector(maxSpeed, velocity.y);
		}
		if(position.y > height - edgeDistance) {
			desired = new PVector(velocity.x, -maxSpeed);
		} else if(position.y < edgeDistance) {
			desired = new PVector(velocity.x, maxSpeed);
		}
		if(desired != null) {
			steering = PVector.sub(desired, velocity);
			steering.limit(maxForce);
			return steering; //RETURN STEERING FORCE
		} else {
			return new PVector(0,0);
		}

	}

}

