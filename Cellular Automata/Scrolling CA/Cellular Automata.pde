class CellularAutomata {

	int[] cells;
	int[] ruleSet;
	ArrayList <int[]> generations;
	int scale;
	int maxGenerations;
	int numberOfGenerations;

	CellularAutomata(int scale, int rule) {

		this.scale = scale;
		maxGenerations = height / scale;
		numberOfGenerations = 1;
		generations = new ArrayList <int []> ();
		ruleSet = new int[8];
		cells = new int[width/scale];
		for(int i = 0 ; i < cells.length ; i++) {
				cells[i] = 0;
			}

		cells[cells.length/2] = 1;
		generations.add(cells);
		String s = Integer.toBinaryString(rule);
		for(int i = 0 ; i < s.length() ; i++) {
			ruleSet[s.length() - i - 1] = s.charAt(i) - 48;
		}

	}

	void generate() {
		
		int me, left, right;
		int [] nextGen = new int[cells.length];

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
		generations.add(nextGen);
		
		if(numberOfGenerations > maxGenerations) {
			generations.remove(0);
		} else {
			numberOfGenerations++;
		}
	}

	int rules(int left, int me, int right) {

		String s = "" + left + me + right;
		int index = Integer.parseInt(s,2);
		return ruleSet[index];
	}

	void draw() {
		for(int i = 0; i < generations.size() ; i++) {
			int[] array = generations.get(i);
			for(int j = 0 ; j < array.length ; j++) {
				if(array[j] == 1) fill(0);
				else fill(255);
				rect(j * scale, height - numberOfGenerations * scale + i * scale , scale, scale);
			}
		}
	}
}
