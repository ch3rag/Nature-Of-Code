/*

POPULATION HAS :

 	A NUMBER OF OBJECTS THAT WILL LIVE IN IT
 	A MUTATIONRATE TO MUTATE THE DNA OF TWO CROSSOVERED PARENTS
 	A LIFESPAN MEASURED IN NUMBER OF FRAMES
	A ORIGIN THAT DEFINES WHERE ROCKETS WILL START
	A TARGET THAT DEFINES WHERE ROCKETS ARE SUPPOSED TO GO

*/



Population population;
int numPopulation = 100;
float mutationRate = 0.01;
PVector origin;
PVector target;
int lifeSpan = 200;


void setup() {
	
	size(800, 800);
	origin = new PVector(width/2, height - 10);
	target = new PVector(width/2, 20);
	population = new Population(numPopulation, mutationRate, lifeSpan, origin, target);
}

void draw() {

	background(255);
	population.step();

}

//CHANGES TARGET TO MOUSE(X,Y)

void mousePressed() {
	population.target.x = mouseX;
	population.target.y = mouseY;
}
