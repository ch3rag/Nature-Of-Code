GameOfLife gol;

void setup() {  
	size(800, 800);
	gol = new GameOfLife(10);
	noStroke();
}

void draw() {
 	background(255);
 	gol.draw();
	gol.generate();

}
