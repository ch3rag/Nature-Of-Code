class Perlin2D {

	int grid[][] = {
		 			{1,  1},
		 			{-1, 1},
		 			{1, -1},
		 			{-1,-1}
					};

	int permutation[] =  
					 {151,160,137,91,90,15,
					 131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
					 190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
					 88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
					 77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
					 102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
					 135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
					 5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
					 223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
					 129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
					 251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
					 49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
					 138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180,151,
					 160,137,91,90,15,
					 131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
					 190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
					 88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
					 77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
					 102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
					 135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
					 5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
					 223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
					 129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
					 251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
					 49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
					 138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180};



	double dotProduct(int gridPoint[], double x, double y) {
		return gridPoint[0] * x + gridPoint[1] * y;

	}

	double linearInterpolate(double a, double b, double x) {
		return (1 - x) * a + b * x;
	}

	double smoothStep(double t) {
 		return t*t*t*(t*(t*6-15)+10);
 	}

 	 int fastfloor(double x) {
 	return x>0 ? (int)x : (int)x-1;
 	}

 	double cosineInterpolate(double a, double b, double x) {
 		double ft = (1 - cos((float)(x * PI))) / 2;
 		return ((a * (1 - ft)) + (b * ft));
	}

	double getNoise(double x, double y) {
 
		int X = (int)(x);
		int Y = (int)(y);
		
		x = x - X;
		y = y - Y;

		X = X & 255;
		Y = Y & 255;

		int g00 = permutation[X + permutation[Y]] % 4;
		int g01 = permutation[X + permutation[Y + 1]] % 4;
		int g10 = permutation[X + 1 + permutation[Y]] % 4;
		int g11 = permutation[X + 1 + permutation[Y + 1]] % 4;

		double n00 = dotProduct(grid[g00], x , y);
		double n01 = dotProduct(grid[g01], x , y - 1);
		double n10 = dotProduct(grid[g10], x - 1 , y);
		double n11 = dotProduct(grid[g11], x - 1, y - 1);

		double u = smoothStep(x);
 		double v = smoothStep(y);

		// double nx1 = linearInterpolate(n00, n10,x);
		// double nx2 = linearInterpolate(n01, n11, x);
		// double ny  = linearInterpolate(nx1, nx2, y);

		double nx1 = cosineInterpolate(n00, n10,x);
		double nx2 = cosineInterpolate(n01, n11, x);
		double ny  = cosineInterpolate(nx1, nx2, y);

		return ny;

	}

};


double xoff = 0;
double yoff = 0;
double delta= 0.05;
Perlin2D noise;
void setup() {
	size(640, 360);
	noise = new Perlin2D();

}

void draw() {
	loadPixels();

	for(int i = 0; i < height ; i++) {
		xoff = 0;
		for(int j = 0 ; j < width ; j++) {
			int col = (int)(noise.getNoise(xoff, yoff) * 255); 
			int index = (i * width + j);
			pixels[index]  = color(col,col,col,255);
			xoff += delta;
		}
		yoff += delta;
	}
	updatePixels();
	noLoop();

}
