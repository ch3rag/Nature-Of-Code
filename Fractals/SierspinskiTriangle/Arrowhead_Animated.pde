
// CHIRAG SINGH RAJPUT
// Github.com/IamBharatSingh
// Seirspinski Triangle (Arrow Head Curve Animated)

ArrayList <Line> lines = new ArrayList <Line> ();
ArrayList <Line> previousLine = new ArrayList <Line> ();
int i = -1;
int numFrames = 60;
Line currentLine;
int startFrame;
float currentRotation = 0;
float currentX = 0;
float currentY = 0;
float previousX = 0;
float previousY = 0;
int currentDepth = 0;
int maxDepth = 7;

class Line {

	PVector start;
	PVector end;
	Line(float x1, float y1, float x2, float y2) {
		start = new PVector(x1, y1);
		end   = new PVector(x2, y2);
	}

	void animateLine(int startFrame, int numFrames) {
  		if(frameCount > startFrame && frameCount <= startFrame + numFrames) {
    		float dx = (end.x - start.x)/numFrames;
    		float dy = (end.y - start.y)/numFrames;
    		line(start.x,start.y,start.x + dx * (frameCount - startFrame),start.y + dy * (frameCount - startFrame));
		}
	}

	void draw() {
		line(start.x, start.y, end.x, end.y);
	}
}



void transformed(float tx, float ty, float rotation) {

	previousX = currentX;
	previousY = currentY;

	if(currentRotation != 0) {
		float len = dist(currentX, currentY, currentX + tx, currentY + ty);
		currentX += len * cos(currentRotation);
		currentY += len * sin(currentRotation);
	} else {
		currentX += tx;
		currentY += ty;
	}
	currentRotation += rotation;
	translate(tx, ty);
	rotate(rotation);
}



void setup() {
	
	size(640, 480);
	strokeWeight(3);
	stroke(255);
	colorMode(HSB);
	pushMatrix();
	sierspinski(100, height-80, width-200, currentDepth);  //START WITH DEPTH 0
	popMatrix();

}


void draw() {

	background(0);
	textSize(25);
	textAlign(CENTER);
	text("DEPTH " + currentDepth, width/2, height-25);
	if((frameCount % numFrames == 0 || currentLine == null) && ++i < lines.size()) {
		currentLine = lines.get(i);
		startFrame = frameCount;
	}
	for(int k = 0 ; k < i; k++) {
		stroke(map(k, 0, lines.size(), 0, 255), 255, 255);
		lines.get(k).draw();
	}
	stroke(map(i, 0, lines.size(), 0, 255), 255, 255);
	currentLine.animateLine(startFrame, numFrames-1);
	if(i == lines.size()) noLoop();

	if(previousLine != null) {
		for(Line l : previousLine) {
			stroke(255,75);
			l.draw();
		}
	} 
}

void sierspinski(float x, float y, float length, int depth) {

	pushMatrix();
	transformed(x, y,0);
	
	if(depth % 2 == 0) {
		drawLines(length, depth, PI/3);
	} else {
		transformed(0,0, -PI/3);
		drawLines(length, depth, PI/3);
	}
	popMatrix();
}

void drawLines(float length, int depth, float angle) {

	if(depth == 0) {
		transformed(length,0,0);
		lines.add(new Line(previousX, previousY, currentX, currentY));
	} else {

		drawLines(length/2, depth - 1,- angle);
		transformed(0,0,angle);
		drawLines(length/2, depth - 1,+ angle);
		transformed(0,0,angle);
		drawLines(length/2, depth - 1,- angle);

	}
}

void mousePressed() {
	if(currentDepth < maxDepth && !looping) {
		i = -1;
		currentX = 0;
		currentY = 0;
		currentRotation = 0;
		previousLine = lines;
		currentDepth++;
		numFrames = (int)ceil(map(currentDepth,0,maxDepth,10,1));
		lines = new ArrayList <Line> ();
		pushMatrix();
		sierspinski(100, height-80, width-200, currentDepth);
		popMatrix();
		loop();
	}
}
