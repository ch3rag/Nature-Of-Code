class DNA {

	char[] genes;
	float fitness;
	
	DNA(int length) {

		genes = new char[length];
		for(int i = 0 ; i < genes.length ; i++) {
			genes[i] = (char) random(32, 128);
		}

	}

	float fitness(String target) {
		int score = 0;
		for(int i = 0 ; i < genes.length ; i++) {
			if(genes[i] == target.charAt(i)) {
				score++;
			}
		}

		fitness = float(score)/target.length();
		return fitness;
	}

	DNA crossOver(DNA partner) {

		DNA child = new DNA(genes.length);

		//int midPoint = (int)random(genes.length);
		for(int i = 0 ; i < genes.length ; i++) {
			// if(i > midPoint) child.genes[i] = this.genes[i];	
			// else child.genes[i] = partner.genes[i];
			if(random(1) > 0.5) child.genes[i] = this.genes[i];
			else child.genes[i] = partner.genes[i];
		}

		return child;

	}

	void mutate(float mutationRate) {

		for(int i = 0 ; i < genes.length ; i++) {

			if(random(1) < mutationRate) {
				genes[i] = (char) random(32, 128);
			}
		}
	}

	String getGenes() {
		return new String(genes);
	}

}
