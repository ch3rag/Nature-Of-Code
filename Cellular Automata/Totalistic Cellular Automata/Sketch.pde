
CellularAutomata ca;

int rule;

int getRule() {
	return rule = (int)random(2188);
}

void setup() {


	fullScreen();
	ca = new CellularAutomata(3, getRule());
	noStroke();
	background(255);
}


void mousePressed() {
	println("rule = " + rule + ";");
	ca = new CellularAutomata(3, getRule());
	background(255);
}

void draw() {
	ca.draw();
	ca.generate();
	fill(255,0,0);
	text(rule, 10,40);
}
