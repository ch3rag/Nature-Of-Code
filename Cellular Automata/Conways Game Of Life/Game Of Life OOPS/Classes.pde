class Cell {

	int x;
	int y;
	int state;
	int previous;
	int scale;

	Cell(int x, int y, int scale, int state) {

		this.x = x;
		this.y = y;
		this.state = state;
		this.scale = scale;
		this.previous = state;
	}

	void draw() {

		if(state == 0 && previous == 1) fill(255,0,0); //DEAD
		else if(state == 1 && previous == 0) fill(0,255,0); //BIRTH
		else if(state == 1) fill(0);
		else fill(255);
		rect(x,y,scale,scale);

	}

	void setState(int newState) {
		state = newState;
	}
}

class GameOfLife {

	Cell[][] grid;
	int rows;
	int cols;


	GameOfLife(int scale) {

		rows = height / scale;
		cols = width  / scale;

		grid = new Cell[rows][cols];

		for(int i = 0 ; i < grid.length ; i++) {
			for(int j = 0 ; j < grid[0].length ; j++) {
				int state = 0;
				if(i == j) state = 1;
				if(i + j == cols - j - i + rows)  state = 1;
				grid[i][j] = new Cell(j * scale, i * scale, scale, state);
			}
		}
	}


	void draw() {
		for(Cell[] rows : grid) {
			for(Cell c : rows) {
				c.draw();
			}
		}
	}

	void generate() {

     	for ( int i = 0; i < rows;i++) {
      		for ( int j = 0; j < cols;j++) {
        		grid[i][j].previous = grid[i][j].state;
      		}
   		 }

		for(int i = 0 ; i < grid.length ; i++) {
			for(int j = 0 ; j < grid[0].length ; j++) {
				int total = 0;
				for(int x = -1 ; x <= 1 ; x++) {
					for(int y = -1 ; y <= 1 ; y++) {
						total += grid[(i + x + rows) % rows][(j + y + cols) % cols].previous;
					}
				}
				total -= grid[i][j].previous;
				if((grid[i][j].state == 1) && (total > 3)) grid[i][j].setState(0);
				else if((grid[i][j].state == 1) && (total < 2)) grid[i][j].setState(0);	
				else if((grid[i][j].state == 0) && (total == 3)) grid[i][j].setState(1);
			}
		}
	}
}


