CellularAutomata ca;

int rule;
int[] generateRuleSet() {

	rule = (int)random(255);
	int[] ruleSet = new int[8];
	String s = Integer.toBinaryString(rule);
	for(int i = 0 ; i < s.length() ; i++) {
		 ruleSet[s.length() - i - 1] = s.charAt(i) - 48;
	}
	return ruleSet;
}

void setup() {
	fullScreen();
	ca = new CellularAutomata(5, generateRuleSet());
	noStroke();
	background(0);

}

void mousePressed() {
			background(0);
			ca = new CellularAutomata(ca.scale, generateRuleSet());
}


void draw() {
		fill(255,0,0);
		ca.generate();
		ca.draw();
}
