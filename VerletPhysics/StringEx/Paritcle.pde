class Particle extends VerletParticle2D {

	Particle(Vec2D pos) {

		super(pos);
	}

	void draw() {
		pushMatrix();
		fill(175);
		stroke(0);
		ellipse(x, y, 34, 34);
		popMatrix();
	}


}
