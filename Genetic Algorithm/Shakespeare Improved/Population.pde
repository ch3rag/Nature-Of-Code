class Population {

	DNA[] population;
	DNA fittest;
	String target;
	ArrayList <DNA> matingPool;
	float mutationRate;
	int generation;
	float averageFitness;


	Population(int size, String target, float mutationRate) {

		population = new DNA[size];
		for(int i = 0 ; i < population.length ; i++) {
			population[i] = new DNA(target.length());
		}
		this.target = target;
		this.mutationRate = mutationRate;
		generation = 0;
		this.matingPool = new ArrayList <DNA> ();
	}

	//CALCULATES FITTEST ELEMENT, AVERAGE FITNESS, AND FITNESS OF ALL ELEMENTS

 	void calcFitness() {
		float max = -1;
		float total = 0;
		for(DNA d : population) {
			float current = d.fitness(target);
			total += current;
			if(current > max) {
				fittest = d;
			}
		}

		averageFitness = total / population.length;
	}

	void createMatingPool() {
		
		matingPool.clear();

		//MONTE CARLO APPROCH

		//while(matingPool.size() < population.length) {

		// 	int i = (int)random(population.length);
		// 	float qualifier = random(1);

		// 	if(qualifier < population[i].fitness) {
		// 		matingPool.add(population[i]);
		// 	}

		// }

		//SHIFFMAN'S APPROCH

		for(int i = 0 ; i < population.length ; i++) {
			float fitness = map(population[i].fitness, 0, fittest.fitness,0,1);
			int n = (int) (fitness * 100);
			for(int j = 0 ; j < n ; j++) {
				matingPool.add(population[i]);
			}
		}

	}

	void generateNewPopulation() {

		DNA[] next = new DNA[population.length];

		for(int i = 0 ; i < population.length ; i++) {
		
			int a = (int)random(matingPool.size());
			int b = (int)random(matingPool.size());
			DNA parentA = matingPool.get(a);
			DNA parentB = matingPool.get(b);
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
 }


