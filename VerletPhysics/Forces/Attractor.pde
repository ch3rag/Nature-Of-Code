class Attractor extends VerletParticle2D {

	Attractor(Vec2D pos) {

		super(pos);
		physics.addBehavior(new AttractionBehavior(this, 100, -1));
		physics.addBehavior(new AttractionBehavior(this, width, 0.1));

	}

	void draw() {

		fill(175);
		strokeWeight(2);
		ellipse(x, y, 40, 40);

	}
}
