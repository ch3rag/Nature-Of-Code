/*

	position     : CURRENT POSITION OF THE ROCKET
	velocity     : CURRENT VELOCOTY OF THE ROCKET
	acceleration : CURRENT ACCELERATION OF THE ROCKET
	gene  		   : AN OBJECT OF TYPE DNA THAT STORES AN ARRAY (gene.dna) CONTAINING RANDOM PVECTORS
	fitness      : FITNESS OF THE ROCKET
	timeTaken    : HOW MUCH DNA IS UTILIZED TO REACH THE TARGET
	isReached    : BOOLEAN TO STORE WHETHER THE ROCKET MADE IT TO THE TARGET

*/

class Rocket {
	
	PVector position;
	PVector velocity;
	PVector acceleration;
	DNA genes;
	float fitness;
	int timeTaken;
	boolean isReached;


	Rocket(PVector origin, DNA dna) {

		position = origin.get();
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);
		this.genes = dna;
		isReached = false;
		timeTaken = 0;
	}

	void update() {

			velocity.add(acceleration);
			position.add(velocity);
			acceleration.mult(0);
	}

	void applyForce(PVector force) {
		acceleration.add(force);
	}

	void checkForTarget(PVector target) {

		float distance = PVector.dist(target, position);
		// TARGET REACHED THRESHOLD = 10
		if(distance < 20) isReached = true;
	}

	void calcFitness(PVector target) {

			float distance = PVector.dist(target, position);
			fitness = 1/(distance+timeTaken);
	}

	void draw() {
		pushMatrix();
			translate(position.x, position.y);
			rotate(velocity.heading() - PI/2);
			stroke(0);
			fill(175);
			triangle(-5, 0, 0, 20, 5, 0);
		popMatrix();
	}


	void fire(int geneCounter) {
		applyForce(genes.dna[geneCounter]);
		timeTaken++;
	}

	float getFitness() {
		return fitness;
	}

	DNA getDNA() {
		return genes;
	}

	boolean  checkIfReached() {
		return isReached;
	}
}
