Population population;
String target = "to be or not to be";
int popluationSize = 300;
float mutationRate = 0.005;

void setup() {
	size(640, 480);
	population = new Population(popluationSize,target,mutationRate);
	background(255);

}

void draw() {

	background(255);
	population.calcFitness();
	population.createMatingPool();
	population.generateNewPopulation();
	population.display();
	if(population.evaluate()) noLoop();

}
