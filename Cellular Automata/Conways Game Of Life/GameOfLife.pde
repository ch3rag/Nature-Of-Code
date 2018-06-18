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
				if(i == 0) total += grid[rows - 1][j];
				else total += grid[i - 1][j];

				if(i == rows - 1) total += grid[0][j];
				else total += grid[i + 1][j];

				if(j == 0) total += grid[i][cols - 1];
				else total += grid[i][j - 1];

				if(j == cols - 1) total += grid[i][0];
				else total += grid[i][j + 1];

				 if(i == 0 && j == 0) total += grid[rows - 1][cols - 1];
				 else if(i == 0 && j >= 0) total += grid[rows - 1][j - 1];
				 else if(i >= 0 && j == 0) total += grid[i - 1][cols - 1];
				 else total += grid[i - 1][j - 1];

		 		 if(i == 0 && j == cols - 1) total += grid[rows - 1][0];
				 else if(i == 0 && j >= 0) total += grid[rows - 1][j + 1];
				 else if(i >= 0 && j == cols - 1) total += grid[i - 1][0];
				 else total += grid[i - 1][j + 1];

				 if(i == rows - 1 && j == cols - 1) total += grid[0][0];
				 else if(i >= 0 && j == cols - 1) total += grid[i + 1][0];
				 else if(i == rows - 1 && j >= 0) total += grid[0][j + 1];
				 else total += grid[i + 1][j + 1];

		 		 if(i == rows - 1 && j == 0) total += grid[0][cols - 1];
				 else if(i == rows - 1 && j >= 0) total += grid[0][j - 1];
				 else if(i >= 0 && j == 0) total += grid[i+1][cols - 1];
				 else total += grid[i + 1][j - 1];

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
