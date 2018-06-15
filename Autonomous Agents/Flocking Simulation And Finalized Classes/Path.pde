class Path {

	ArrayList <PVector> points = new ArrayList <PVector> ();
	int radius;

	Path() {

		radius = 20;
	}

	void addPoint(float x, float y) {

		points.add(new PVector(x,y));

	}

	void draw() {

		beginShape();
		noFill();
		stroke(0, 75);
		strokeWeight(radius * 2);
		for(int i = 0 ; i < points.size() ; i++) {
			PVector p1 = points.get(i);
			vertex(p1.x, p1.y);
		}
		endShape(CLOSE);
		beginShape();
		noFill();
		stroke(0);
		strokeWeight(2);
		
		for(int i = 0 ; i < points.size() ; i++) {
			PVector p1 = points.get(i);
			vertex(p1.x, p1.y);
		}
		endShape(CLOSE);
	}

	PVector getNormalPoint(PVector start, PVector end, PVector location) {

		PVector a = PVector.sub(location, start);
		PVector b = PVector.sub(end, start);
		b.normalize();
		b.mult(a.dot(b));
		PVector normalPoint = PVector.add(start, b);
		return normalPoint;
	}
}
