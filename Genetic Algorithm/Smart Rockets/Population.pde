/*
	
	population   : ARRAY OBJECT TO STORE ALL ROCKETS
	mutationRate : MUTATION RATE
	origin       : COORDINATES FOR THE STARTING POSITION
	target       : COORDINATES FOR THE TARGET POSITION
	lifeSpan     : LIFESPAN OF ROCKETS
	geneCounter  : KEEPS TRACK OF HOW MUCH OF THE DNA ARRAY (CONTAINS RANDOM PVECTORS THAT WILL BE APPLIED AS FORCE) IS USED UP AS FUEL
	maxFitness   : FITNESS OF THE FITTEST ROCKET
	matingPool   : ARRAYLIST TO STORE THE ROCKETS WEIGHTED ON THE BASIS OF THEIR FITNESS

*/

class Population {
	
	Rocket[] population;
	float mutationRate;
	PVector origin;
	PVector target;
	int lifeSpan;
	int geneCounter;
	float maxFitness;
	ArrayList <Rocket> matingPool;

	Population(int numPopulation, float mRate, int lifeSpan, PVector origin, PVector target) {
		
		population = new Rocket[numPopulation];
		this.origin = origin;
		this.target = target;
		mutationRate = mRate;
		this.lifeSpan = lifeSpan;
		geneCounter   = 0;
		matingPool = new ArrayList <Rocket> ();

		for(int i = 0 ; i < population.length ; i++) {
			population[i] = new Rocket(origin, new DNA(lifeSpan));
		}
	}

	void step() {

		if(geneCounter == lifeSpan) {

			geneCounter = 0;
			calcFitness();
			createMatingPool();
			generateNewPopulation();

		} else {

			for(Rocket rocket : population) {
				if(!rocket.checkIfReached()) {
					rocket.fire(geneCounter);
					rocket.update();
					rocket.draw();
					rocket.checkForTarget(target);
				}
			}

			geneCounter++;
			drawTarget();
		}
	}


	void calcFitness() {

		maxFitness = 0;
		for(Rocket rocket : population) {
			rocket.calcFitness(target);
			float fitness = rocket.getFitness();
		if(fitness > maxFitness) maxFitness = fitness;
		}
	}

	void generateNewPopulation() {

		Rocket[] next = new Rocket[population.length];

		for(int i = 0 ; i < population.length ; i++) {

			int a = (int) random(matingPool.size());
			int b = (int) random(matingPool.size());			

			Rocket parentA = matingPool.get(a);
			Rocket parentB = matingPool.get(b);

			DNA parentAGenes = parentA.getDNA();
			DNA parentBGenes = parentB.getDNA();
			
			DNA childDNA = parentAGenes.crossOver(parentBGenes);
			childDNA.mutate(mutationRate);

			Rocket child = new Rocket(origin, childDNA);

			next[i] = child;

		}

		population = next;
	}

	void createMatingPool() {

		matingPool.clear();
		
		for(Rocket rocket : population) {
			int score = int(map(rocket.getFitness(), 0, maxFitness, 0 , 1));
			for(int i = 0 ; i < score ; i++) matingPool.add(rocket);
		}
	}

	void drawTarget()	{
		ellipse(target.x, target.y, 40, 40); 
	}
}
