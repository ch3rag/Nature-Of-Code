class Box {

	Body body;
	float w;
	float h;

	Box(float x, float y, float w, float h, boolean fixed) {

		this.w = w;
		this.h = h;


		BodyDef bd = new BodyDef();
		
		if(fixed) bd.type = BodyType.STATIC;
		else bd.type = BodyType.DYNAMIC;

		bd.position.set(box2d.coordPixelsToWorld(x, y));
		
		body = box2d.createBody(bd);

		PolygonShape ps = new PolygonShape();
		float boxW = box2d.scalarPixelsToWorld(w/2);
		float boxH = box2d.scalarPixelsToWorld(h/2);
		ps.setAsBox(boxW, boxH);

		FixtureDef fd = new FixtureDef();
		fd.shape = ps;
		fd.density = 1;
		fd.friction = 0.3;
		fd.restitution = 0.5;

		body.createFixture(fd);


	}

	void draw() {

		Vec2 pos = box2d.getBodyPixelCoord(body);
		float angle = -1 * body.getAngle();
		pushMatrix();
		translate(pos.x, pos.y);
		rotate(angle);
		fill(175);
		stroke(0);
		rectMode(CENTER);
		rect(0,0,w,h);
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
