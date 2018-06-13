class KinematicBox {

	Body body;
	float w,h;

	KinematicBox(float x, float y, float w, float h) {

		this.h = h;
		this.w = w;

		BodyDef bd = new BodyDef();
		bd.type = BodyType.KINEMATIC;
		bd.position.set(box2d.coordPixelsToWorld(x,y));
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

	void bind(float x, float y) {

		Vec2 pos = body.getWorldCenter();
		Vec2 target = box2d.coordPixelsToWorld(x,y);
		target.subLocal(pos);
		body.setLinearVelocity(target.mulLocal(10));

	
	}

	void draw() {

		rectMode(CENTER);
		Vec2 pos = box2d.getBodyPixelCoord(body);
		float angle = body.getAngle();
		pushMatrix();
		translate(pos.x, pos.y);
		rotate(-angle);
		stroke(0);
		fill(175);
		rect(0,0,w,h);
		popMatrix();
    
	}
}
