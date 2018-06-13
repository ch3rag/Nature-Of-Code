class Mover {


	Body body;
	float radius = 10;

	Mover (float x, float y) {

		BodyDef bd = new BodyDef();
		bd.type = BodyType.DYNAMIC;
		bd.position.set(box2d.coordPixelsToWorld(x,y));
		body = box2d.createBody(bd);
		CircleShape cs =  new CircleShape();
		cs.m_radius = box2d.scalarPixelsToWorld(radius);
		body.createFixture(cs,1);


	}

	void draw() {

		Vec2 pos = box2d.getBodyPixelCoord(body);
		float angle = body.getAngle();
		pushMatrix();
		stroke(0);
		fill(255);
		translate(pos.x,pos.y);
		rotate(-angle);
		ellipse(0, 0, radius*2, radius*2);
		line(0,0,radius,0);
		popMatrix();
	}


	Boolean killBody() {

		Vec2 pos = box2d.getBodyPixelCoord(body);

		if(pos.x > width || pos.x  < 0 || pos.y > height || pos.y < 0) {

			box2d.destroyBody(body);
			return true;
		}

		return false;

	}

	void applyForce(Vec2 force) {

		Vec2 pos = body.getWorldCenter();
		body.applyForce(force, pos);

	}
}
