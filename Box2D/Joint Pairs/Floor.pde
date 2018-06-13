class Floor {

	float x,y,w,h;
	Body body;

	Floor(float x, float y, float w, float h) {

		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;

		BodyDef bd = new BodyDef();

		bd.type = BodyType.STATIC;
		bd.position.set(box2d.coordPixelsToWorld(x + w/2, y + h/2));
		body = box2d.createBody(bd);

		PolygonShape ps = new PolygonShape();
		float fW = box2d.scalarPixelsToWorld(w/2);
		float fH = box2d.scalarPixelsToWorld(h/2);
		ps.setAsBox(fW,fH);

		body.createFixture(ps, 1);

	}

	void draw() {

		fill(0);
		noStroke();
		rect(x, y, w ,h);

	}

}
