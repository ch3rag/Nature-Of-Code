import java.util.Arrays;

GameOfLife gol;
void setup() {

	size(800,800);
	gol = new GameOfLife(5);
	noStroke();
}

void draw() {
	background(255);
	gol.draw();
	gol.generate();
}

