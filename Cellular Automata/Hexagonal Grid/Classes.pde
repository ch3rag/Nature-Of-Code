
void polygon(float x, float y, float radius, float numPoints) {
	float delta = TWO_PI / numPoints;
	beginShape();
	for(float i = 0 ; i < TWO_PI ; i += delta) {
		float a = x + radius * cos(i);
		float b = y + radius * sin(i);
 		vertex(a, b);
	}

	endShape();
}


class Cell {

	float x;
	float y;
	int state;
	int previous;
	float scale;
	
	Cell(float x, float y, float scale) {

		this.x = x;
		this.y = y;
		this.scale = scale;
		this.state = (int)random(2);
		this.previous = state;

	}


	void setState(int state) {

		this.state = state;

	}

	void draw() {
		
		if(state == 1) fill(0);
		else fill(255);
		polygon(x,y,scale, 6);
	}	

}

class GameOfLife {

	Cell[][] grid;
	float scale;
	int rows;
	int cols;

	GameOfLife(float scale) {
		float yoff = scale * sin(PI/3);
		float xoff = 1.5 * (float)scale;
		this.scale = scale;
		this.cols  = ceil(width/xoff);
		this.rows  = ceil(height/(yoff*2));

		println(rows + ", " + cols);

		grid = new Cell[(int)rows][(int)cols];

		for(int i = 0 ; i < grid.length ; i++) {
			for(int j = 0 ; j < grid[0].length ; j++) {
				if(j % 2 == 0) grid[i][j] = new Cell(j * scale + scale/2 * j,i * yoff * 2 + yoff, scale);
				else grid[i][j] = new Cell(j * scale + scale/2 * j, i * yoff * 2 + yoff * 2, scale);
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
