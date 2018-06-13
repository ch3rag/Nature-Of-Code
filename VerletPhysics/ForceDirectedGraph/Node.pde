class Node extends VerletParticle2D {

	Node(Vec2D pos) {

		super(pos);
	}

	void draw() {
		pushMatrix();
		fill(175);
		stroke(0);
		ellipse(x, y, 16, 16);
		popMatrix();
	}

}
