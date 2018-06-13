class Circle {

	Body body;
	float radius = 7;


	Circle(float x, float y, boolean fixed) {

		BodyDef bd = new BodyDef();
		if(fixed) bd.type = BodyType.STATIC;
		else  bd.type = BodyType.DYNAMIC;
		bd.position.set(box2d.coordPixelsToWorld(x,y));

		body = box2d.createBody(bd);

		CircleShape cs = new CircleShape();
		cs.m_radius = box2d.scalarPixelsToWorld(radius);

		FixtureDef fd = new FixtureDef();
		fd.shape = cs;
		fd.density = 1;
		fd.friction = 0.5;
		fd.restitution = 0.3;

		body.createFixture(fd);


	}


	void draw() {

		Vec2 pos = box2d.getBodyPixelCoord(body);
		float angle = body.getAngle();
		pushMatrix();
		fill(175);
		stroke(0);
		translate(pos.x,pos.y);
		rotate(-angle);
		ellipse(0, 0, radius * 2, radius * 2);
		line(0,0,radius,0);
		popMatrix();

	}
}
