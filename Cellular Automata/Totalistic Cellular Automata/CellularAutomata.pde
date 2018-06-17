//RULE = 451

class CellularAutomata {

	int[] ruleSet;
	int[] cells;
	int scale;
	int generations = 0;

	CellularAutomata(int scale, int rule) {
		this.scale = scale;
		ruleSet = new int[7]; 
		cells = new int[width/scale];
		int i;
		for(i = 0 ; i < cells.length ; i++) {
			cells[i] = 0;
		}
		cells[cells.length/2] = 1;
		i = 0;
		while(rule > 0) {
			ruleSet[i] = rule % 3;
			rule /= 3;
			i++;
		}
		//println(ruleSet);
	}

	void generate() {
		int[] nextGen = new int[cells.length];
		int left, right, me;
		for(int i = 0 ; i < cells.length ; i++) {

			if(i == 0) {
				left = cells[cells.length - 1];
			} else {
				left = cells[i - 1];
			}

			if(i == cells.length - 1) {
				right = cells[0];
			} else {
				right = cells[i + 1];
			}

			me = cells[i];
			nextGen[i] = rules(left, me, right);
		}

		cells = nextGen;
		generations++;
	}

	int rules(int left, int me, int right) {

		int total = left + right + me;
		return ruleSet[total];
	}

	void draw() {
	
		for(int i = 0 ; i < cells.length ; i++) {
			if(cells[i] == 2) fill(0);
			else if(cells[i] == 1) fill(125);
			else fill(255);
			rect(i * scale, generations * scale, scale,scale);
		}
	}
}

