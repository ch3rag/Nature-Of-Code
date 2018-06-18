GameOfLife gol;
void setup() {

	size(640, 480);
	gol = new GameOfLife(5);

}

void draw() {

	background(255);
	gol.draw();
}


