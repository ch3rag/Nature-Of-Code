class Diamond {

	Body body;
	int scale = 3;

	Diamond(float x, float y) {


		BodyDef bd = new BodyDef();
		bd.position.set(box2d.coordPixelsToWorld(x,y));
		bd.type = BodyType.DYNAMIC;
		body = box2d.createBody(bd);

		Vec2[] v = new Vec2[5];
		v[0] = box2d.vectorPixelsToWorld(0, scale * -3);
		v[1] = box2d.vectorPixelsToWorld(2 * scale, 0);
		v[2] = box2d.vectorPixelsToWorld(1.3 * scale, 1 * scale);
		v[3] = box2d.vectorPixelsToWorld(-1.3 * scale, 1 * scale);
		v[4] = box2d.vectorPixelsToWorld(-2 * scale,0);


		PolygonShape ps = new PolygonShape();
		ps.set(v, v.length);

		FixtureDef fd = new FixtureDef();
		fd.shape = ps;
		fd.friction = 0.3;
		fd.restitution = 0.5;
		fd.density = 1;

		body.createFixture(fd);
	}

	void draw() {

		Vec2 pos = box2d.getBodyPixelCoord(body);
		float angle = body.getAngle();

		Fixture f = body.getFixtureList();
		PolygonShape ps = (PolygonShape) f.getShape();

		rectMode(CENTER);
		stroke(0);
		fill(175);
		pushMatrix();
		translate(pos.x, pos.y);
		rotate(-angle);
		beginShape();
		for(int i = 0 ; i < ps.getVertexCount() ; i++) {

			Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
			vertex(v.x,v.y);

		}

		endShape(CLOSE);
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
