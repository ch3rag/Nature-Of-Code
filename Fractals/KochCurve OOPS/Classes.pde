class KochLine {
	PVector start;
	PVector end;

	KochLine(PVector a, PVector b) {
		start = a.get();
		end   = b.get();
	}

	void draw() {
		stroke(0);
		line(start.x, start.y, end.x, end.y);
	}

	PVector kochA() {
		return start.get();
	}

	PVector kochE() {
		return end.get();
	}

	PVector kochB() {

		PVector b = PVector.sub(end,start);
		b.div(3);
		b.add(start);
		return b;
	}

	PVector kochC() {

		PVector c = PVector.sub(end, start);
		c.div(3);
		PVector v = c.get();
		v.add(start);
		c.rotate(-PI/3);
		c.add(v);
		return c;
	}

	PVector kochD() {
		PVector d = PVector.sub(end, start);
		d.div(3);
		PVector v = d.get();
		v.add(start);
		d.add(v);
		return d;
	}
 
}
