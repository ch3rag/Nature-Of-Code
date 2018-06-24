class Particle extends VerletParticle2D {
	Particle parent;
	Particle(Vec2D position, Particle parent) {
		super(position);
		this.parent = parent;
		physics.addBehavior(new AttractionBehavior(this,40,-0.5));
	}

}
