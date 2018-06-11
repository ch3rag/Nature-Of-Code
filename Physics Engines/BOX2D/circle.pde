class Circle {

	float radius = random(10,20);
	Body body;

	Circle(float x, float y) {

		BodyDef bd = new BodyDef();
		bd.position.set(box2d.coordPixelsToWorld(x,y));
		bd.type = BodyType.DYNAMIC;
		body = box2d.createBody(bd);

		CircleShape cs = new CircleShape();
		cs.m_p.set(0,0); //POSITION RELATIVE TO THE CENTER
		cs.m_radius = box2d.scalarPixelsToWorld(radius/2);

		FixtureDef fd = new FixtureDef();
		fd.friction = 0.3;
		fd.restitution = 0.5;
		fd.density = 1;
		fd.shape = cs;

		body.createFixture(fd);
	}

	void draw() {

		stroke(0);
		fill(175);
		Vec2 pos = box2d.getBodyPixelCoord(body);
		float angle = -1 * body.getAngle();
		pushMatrix();
		translate(pos.x,pos.y);
		rotate(angle);
		ellipse(0, 0, radius, radius);
		line(0,0,0,radius/2);
		popMatrix();

	}

	boolean killBody() {
		Vec2 pos = box2d.getBodyPixelCoord(body);
		if(pos.x > width || pos.x < 0 || pos.y > height || pos.y <0) {
			box2d.destroyBody(body);
			return true;
		} 
		return false;
	}





}