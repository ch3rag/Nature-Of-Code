class Node extends VerletParticle2D {
	Node(Vec2D pos) {

		super(pos);
	}

	void draw() {
		pushMatrix();
		strokeWeight(3);
	    fill(175);
	    ellipse(x, y, 16, 16);
	    popMatrix();
	}

}
