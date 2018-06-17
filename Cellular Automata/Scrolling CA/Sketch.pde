
CellularAutomata ca;

int rule;

int getRule() {
	return rule = (int)random(0, 256);
}

void setup() {

	size(640, 480);
	ca = new CellularAutomata(3, getRule());
	noStroke();
}

void mousePressed() {

	ca = new CellularAutomata(3, getRule());
	background(255);
}

void draw() {

	background(255);
	ca.draw();
	ca.generate();
	fill(255,0,0);
	text(rule, 10,10);

}
