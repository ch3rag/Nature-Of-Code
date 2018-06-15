class Path {

	PVector start;
	PVector end;
	int radius;

	Path() {

		start = new PVector(0, height/3);
		end   = new PVector(width, 2 * height/3);
		radius = 20;
	}

	void draw() {

		strokeWeight(radius * 2);
		stroke(0, 75);
		line(start.x, start.y, end.x, end.y);
		strokeWeight(1);
		stroke(0);
		line(start.x, start.y, end.x, end.y);

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
