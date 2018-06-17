class CellularAutomata {

	int[] cells;
	int[] ruleSet;
	int scale;
	int generations = -1;

	CellularAutomata(int scale, int[] ruleSet) {

		this.scale = scale;
		cells = new int[(int)width/scale];
		this.ruleSet = ruleSet;

		for(int i = 0 ; i < cells.length ; i++) {

			cells[i] = 0;

		}
		cells[cells.length/2] = 1;
	}

	void generate() {

		int[] nextGen = new int[cells.length];

		for(int i = 1 ; i < cells.length - 1; i++) {
			int left;
			int right;
			if(i == 0) {
				left = cells[cells.length - 1];
			} else {
				left = cells[i - 1];
			}

			int me   = cells[i];

			if(i == cells.length - 1) {
				right = cells[0];
			} else {
				right = cells[i + 1];
			}

			nextGen[i] = rules( left, me, right);
		}

		generations++;

		cells = nextGen;
	}

	int rules(int left, int me, int right) {

		String s = "" + left + me + right ;
		int index = Integer.parseInt(s,2);
		return ruleSet[index];
	}

	void draw() {

		for(int i = 0 ; i < cells.length ; i++) {
			if(cells[i] == 1) fill(255);
			else fill(0,0,0);
			rect(i * scale, generations * scale, scale, scale);
		}
	}
}
