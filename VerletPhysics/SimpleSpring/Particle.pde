class Particle extends VerletParticle2D {

	Particle(Vec2D pos) {

		super(pos);
	}

	void draw() {

		fill(175);
		stroke(0);
		ellipse(x, y, 24, 24);
	}


}
