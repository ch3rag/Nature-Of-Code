ArrayList <KochLine> lines = new ArrayList <KochLine> ();

void setup() {

	size(640, 480);
	PVector start = new PVector(0,height/2);
	PVector end = new PVector(width,height/2);
	lines.add(new KochLine(start, end));
	for(int i = 0 ; i < 5 ; i++) {
		generate();
	}	
}


void generate() {

	ArrayList <KochLine> next = new ArrayList <KochLine> ();
	for(KochLine l : lines) {

		PVector a = l.kochA();
		PVector b = l.kochB();
		PVector c = l.kochC();
		PVector d = l.kochD();
		PVector e = l.kochE();

		next.add(new KochLine(a,b));
		next.add(new KochLine(b,c));
		next.add(new KochLine(c,d));
		next.add(new KochLine(d,e));
	}

	lines = next;


}

void draw() {

	background(255);

	for(KochLine l : lines) {
		l.draw();
	}

}
