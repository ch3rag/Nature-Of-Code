class DNA {
	
	PVector[] dna;
	float maxForce  = 1;

	DNA(int length) {

		dna = new PVector[length];
		for(int i = 0 ; i < dna.length ; i++) {
			float angle = random(TWO_PI);
			dna[i] = new PVector(cos(angle), sin(angle));
			dna[i].mult(random(-maxForce, maxForce));
		}
	}

	DNA() {};

	DNA crossOver(DNA partner) {

		DNA child = new DNA();
		child.dna = new PVector[dna.length];

		for(int i = 0 ; i < dna.length ; i++) {
			if(random(1) < 0.5)  child.dna[i] = dna[i];
			else 				 child.dna[i] = partner.dna[i];
		}

		return child;
	}

	void mutate(float mutationRate) {

		for(int i = 0 ; i < dna.length ; i++) {
			if(random(1) < mutationRate) {
				float angle = random(TWO_PI);
				dna[i] = new PVector(cos(angle), sin(angle));
				dna[i].mult(random(0, maxForce));
			}
		}
	}
}
