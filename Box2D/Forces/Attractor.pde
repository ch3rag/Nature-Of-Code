class Attractor {

	float x;
	float y;
	float radius = 30;
	Body body;
	float G = 1000;

	Attractor (float x, float y) {

		this.x = x;
		this.y = y;
		


		BodyDef bd = new BodyDef();
		bd.type = BodyType.STATIC;
		bd.position.set(box2d.coordPixelsToWorld(x,y));
		body = box2d.createBody(bd);
		CircleShape cs =  new CircleShape();
		cs.m_radius = box2d.scalarPixelsToWorld(radius);
		body.createFixture(cs, 1);


	}

	void draw() {

		stroke(0);
		fill(100);
		ellipse(x, y, radius * 2 , radius * 2);

	}

	void attract(Mover m) {


		Vec2 aPos =	body.getWorldCenter();
		Vec2 mPos = m.body.getWorldCenter();
		Vec2 force = aPos.sub(mPos);

		float distance = force.length();
		distance = constrain(distance, 1, 5);
		force.normalize();
		float strength = ((G * 1 * m.body.m_mass )/ (distance * distance)); //STATIC BODIES HAVE ZERO MASS
		force.mulLocal(strength);
		m.applyForce(force);

	}
} 
