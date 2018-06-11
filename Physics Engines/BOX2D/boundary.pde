class Boundary {

	float x;
	float y;
	float w;
	float h;
	float angle;
	Body body;


	Boundary(float x, float y,  float w, float h, float angle) {

		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.angle = angle;

		BodyDef bd = new BodyDef();
		bd.type = BodyType.STATIC;
		bd.position.set(box2d.coordPixelsToWorld(x,y));
		bd.angle = -angle;
		body = box2d.createBody(bd);
		PolygonShape ps = new PolygonShape();

		float bW = box2d.scalarPixelsToWorld(w/2);
		float bH = box2d.scalarPixelsToWorld(h/2);
		ps.setAsBox(bW, bH);

		body.createFixture(ps,1);

	}

	void draw() {

		stroke(0);
		fill(0);
		pushMatrix();
		translate(this.x, this.y);
		rectMode(CENTER);
		rotate(angle);
		rect(0,0, w, h);
		popMatrix();

	}

}