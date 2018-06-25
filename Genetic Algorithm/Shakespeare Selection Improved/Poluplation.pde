class Population {

	DNA[] population;
	DNA fittest;
	String target;
	float mutationRate;
	int generation;
	float averageFitness;
	float total; //SUM OF ALL FITNESS SCORES


	Population(int size, String target, float mutationRate) {

		population = new DNA[size];
		for(int i = 0 ; i < population.length ; i++) {
			population[i] = new DNA(target.length());
		}
		this.target = target;
		this.mutationRate = mutationRate;
		generation = 0;
	}

	//CALCULATES FITTEST ELEMENT, AVERAGE FITNESS, AND FITNESS OF ALL ELEMENTS

 	void calcFitness() {
		float max = -1;
		total = 0;
		for(DNA d : population) {
			float current = d.fitness(target);
			total += current;
			if(current > max) {
				fittest = d;
			}
		}

		//NORMALIZE ALL SCORES
		for(DNA d : population) {
			d.fitness /= total;
		}

		averageFitness = total / population.length;
	}


	void generateNewPopulation() {

		DNA[] next = new DNA[population.length];

		for(int i = 0 ; i < population.length ; i++) {

			DNA parentA = pickRandomParent();
			DNA parentB = pickRandomParent();
			DNA child   = parentA.crossOver(parentB);
			child.mutate(mutationRate);
			next[i] = child;
		}

		population = next;
		generation++;
	}

	void display() {
		fill(0);
 		textSize(20);
 		text("Best Phrase:", 10, 30);
 		textSize(15);
 		text("Population Size : " + population.length, 10, height - 120);
 		text("Generations : " + generation, 10, height - 90);
 		text("Average Fitness : " + averageFitness, 10, height - 60);
 		text("Mutation Rate : " + mutationRate * 100 +"%", 10, height - 30);
 		text("All Phrases :", width - 150, 30);
 		textSize(40);
 		text(fittest.getGenes(), 10, 100);
 		textSize(15);
 		String phrases = "";
 		for(int i = 0 ; i < min(population.length,18) ; i++) {
 			phrases += population[i].getGenes() + "\n";
 		}
 		text(phrases, width-180,60);
 	}

 	boolean evaluate() {
 		if(fittest.getGenes().equals(target)) {
 			return true;
 		}
 		return false;
 	}

	 DNA pickRandomParent() {
	 	float randomNum = random(1);
	 	int index = 0;
	 	while(randomNum	> 0) {
	 		randomNum = randomNum - population[index].fitness;
	 		index++;
	 	}
	 	index--;
	 	return population[index];
	 }

 }


