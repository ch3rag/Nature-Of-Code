
color[] c = new color[5]; //5 COLOR GRADIENT
float[] position = new float[6]; //GRADIENT POSITION


double l = 3;
double dx = -0.6;
double dy = 0.35;

int maxIterations = 1000;
int pSize = 2048;
color[] pallete = new color[pSize];

double x0; 
double y0;
	

double delta = 0;


color[] colors = new color[16];
//COLOR PALLETE
void setup() {
	
	//size(1000,1000);
	fullScreen();
	background(255);

	c[0] = color(0,   7,   100);
	c[1] = color(32,  107, 203);
	c[2] = color(237, 255, 255);
	c[3] = color(255, 100, 0);
	c[4] = color(0,   2,   0);


	position[0] = 0.0;    
	position[1] = 0.16;   
	position[2] = 0.42;    
	position[3] = 0.6425;  
	position[4] = 0.8575; 
	position[5] = 1;

	generateColors(pSize,c,position);
	//l=0.008986316621303558;dx=-0.7472368776798248;dy=-0.09476391971111298;
	//l=0.004656564444303513;dx=-0.7648130431771278;dy=-0.09637905657291412;
	//l=7.435455918312073E-4;dx=-1.2505583241581917;dy=-0.019036713987588882;
	//l=0.009186990559101105;dx=0.3056444451212883;dy=-0.02184852585196495;
	//l=0.093037199229002;dx=0.14086078107357025;dy=-0.6493883840739727;

}
 

//GENERATES COLOR PALETTE 
void generateColors(float length, color[] colors, float[] intervals) { 
	int d = 0;
	int dt = 0;
	for(int i = 0; i < colors.length ; i++) {
		float cPoint = length*intervals[(i+1)];
		dt = d;
		for(int j = d ; j < cPoint ; j++) {
			float inter = map(j,dt,cPoint,0,1);
			color c_ = lerpColor(c[(i)%colors.length], c[(i+1)%colors.length], inter);
			pallete[d] = c_;
			d++;
		}
	}
}

//CONTROLS TO MOVE THE SKETCH
void keyPressed() { 
	if(keyCode == DOWN) {
		dy +=map((float)l,3,0,0.05,0);
	}
	if(keyCode == UP) {
		dy -= map((float)l,3,0,0.05,0);
	}
	if(keyCode == RIGHT) {
		dx += map((float)l,3,0,0.05,0);
	}
	if(keyCode == LEFT) {
		dx -= map((float)l,3,0,0.05,0);
	}

	if(key == 'z') { //ZOOM IN

		delta = map((float)l,3,0,0.05,0);
		l -= delta;
	}

	if(key == 'x') { //ZOOM OUT

		delta = map((float)l,3,0,0.05,0);
		l += delta;
	}
}



void draw() {

	background(255);
	loadPixels();
	println("l="+l + ";dx=" + dx + ";dy=" + dy+";");
	for(int i = 0 ; i < height ; i++) {
		y0 =  dy + ((double)i/width - 0.5)*l;
		for(int j = 0 ; j < width ; j++) {
			x0 =dx + ((double)j/width - 0.5)*l;
			double x = 0;
			double y = 0;
			int k;
			for(k = 0 ; k < maxIterations ; k++) {
				double xtemp = x;
				x = x*x - y*y + x0;
				y = 2*xtemp*y + y0;
				if(x*x + y*y > 8) {
					break;
				}
			}
			int index = (i * width + j);
			if(k < maxIterations) {
				pixels[index] = mapColor(k, x, y);
			} else {
				pixels[index] = color(0);
			}
		}
	}
	updatePixels();
}




color mapColor(int iterations, double x, double y) {
	double size = sqrt((float)(x * x + y * y));
	double smoothed = log(log((float)size) / log(2)) / log(2);
	int colorI = (int)(sqrt((float)((double)iterations + 1 - smoothed)) * 256 + 0) % pallete.length;
	return pallete[colorI];
}
