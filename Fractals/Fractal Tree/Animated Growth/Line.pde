class Line  {

	PVector start;
	PVector end;
	int strokeW;

	Line(float x1, float y1, float x2, float y2, int strokeW) {
		start = new PVector(x1, y1);
		end   = new PVector(x2, y2);
		this.strokeW = strokeW;
	}

	void animateLine(int startFrame, int numFrames) {
  		if(frameCount > startFrame && frameCount <= startFrame + numFrames) {
    		float dx = (end.x - start.x)/numFrames;
    		float dy = (end.y - start.y)/numFrames;
    		strokeWeight(strokeW);
    		line(start.x,start.y,start.x + dx * (frameCount - startFrame),start.y + dy * (frameCount - startFrame));
		}
	}

	void draw() {
		strokeWeight(strokeW);
		line(start.x, start.y, end.x, end.y);
	}
}
