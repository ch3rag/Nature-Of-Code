

class Cell {
	
	float x;
	float y;
	int state;
	int previous;
	float radius;

	Cell(float x, float y, float radius) {
		this.x = x;
		this.y = y;
		this.radius = radius;
		this.state  =(int)random(2);
		this.previous = state;
	}

	void setState(int state) {
		
		this.state = state;

	}

	void draw() {
		if(state == 1) fill(0);
		else return; //IMPROVES PERFORMANCE A LOT BY DRAWING ONLY ALIVE CELLS
		//else fill(0);
		beginShape();
		for(float i = 0 ; i < TWO_PI ; i += PI/3) {
			vertex(x + radius * cos(i), y + radius * sin(i));
		}
		endShape(CLOSE);
	}
}

class GameOfLife {

	Cell[][] grid;
	int rows;
	int cols;
	float scale;

	GameOfLife(float scale) {
		
		float radius = scale/2;
		float offset = radius * sqrt(3);
		this.scale = scale;
		cols = ceil(width / (1.5 * radius));
		rows = ceil(height/offset);
		grid = new Cell[rows][cols];
		//println("ROWS : " + rows + ", " + "COLS : " + cols);

		for(int i = 0 ; i < grid.length ; i++) {
			for(int j = 0 ; j < grid[0].length ; j++) {
				if(j % 2 == 0) grid[i][j] = new Cell(j * scale - radius/2 * j, i * offset, radius);
				else  grid[i][j] = new Cell(j * scale - radius/2 * j, i * offset + offset/2, radius);
			}
		}
	}

	void generate() {
		for(int i = 0 ; i < grid.length ; i++) {
			for(int j = 0 ; j < grid[0].length; j++) {
			grid[i][j].previous = grid[i][j].state;
		}
	}
		for(int i = 0 ; i < grid.length ; i++) {
			for(int j = 0 ; j < grid[0].length; j++) {
				
				int total = 0;
				for(int x = -1 ; x <= 1 ; x++) {
					for(int y = -1 ; y <= 1 ; y++) {
						total += grid[(i + x + rows)%rows][(j + y + cols)%cols].previous;
					}
				}
				total -= grid[i][j].previous;

				if(grid[i][j].previous == 1 && total > 3) grid[i][j].setState(0);
				else if(grid[i][j].previous == 1 && total < 2) grid[i][j].setState(0);
				else if(grid[i][j].previous == 0 && total == 3) grid[i][j].setState(1);
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
}

