class GameOfLife {

	int[][] grid;
	int[][] newState;
	int scale;
	int rows;
	int cols;


	GameOfLife(int scale) {

		rows = height / scale;
		cols = width  / scale;
		this.scale = scale;
		grid = new int[rows][cols];
		newState = new int[rows][cols];
		for(int i = 0 ; i < rows ; i++) {
			for(int j = 0 ; j < cols ; j++)  {
				if(random(1) > 0.5) {
					grid[i][j] = 1;
				} else grid[i][j] = 0;
				newState[i][j] = 0;
			}
		}
	}

	void generate() {
		for(int i = 0 ; i < rows ; i++) {
			for(int j = 0 ; j < cols ; j++) {
				int total = 0;	
				for(int x = 0-1; x <= 1 ; x++) {
					for(int y = -1 ; y <= 1 ; y++) {
						total += grid[(i + x + rows) % rows][(j + y + cols)%cols];
					}
				}

				total -= grid[i][j];

				if((grid[i][j] == 1) && (total > 3)) newState[i][j] = 0;
				else if((grid[i][j] == 1) && (total < 2)) newState[i][j] = 0;	
				else if((grid[i][j] == 0) && (total == 3)) newState[i][j] = 1;
				else newState[i][j] = grid[i][j];

			}
		}
		for(int i = 0 ; i < newState.length ; i++) {
			grid[i] = Arrays.copyOf(newState[i], newState[i].length);
		}
	}

	void draw() {

		for(int i = 0 ; i < rows ; i++) {
			for(int j = 0 ; j < cols ; j++) {
				if(grid[i][j] == 1) fill(0);
				else fill(255);
				rect(j * scale, i * scale, scale, scale);
			}
		}
	}
}
