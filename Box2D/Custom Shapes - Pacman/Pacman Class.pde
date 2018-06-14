class Pacman {

	Body body;
	ArrayList <Vec2> vUpper;
	ArrayList <Vec2> vLower;
	float radius = 10;

	Pacman(float x, float y) {

	

		BodyDef bd = new BodyDef();
		bd.type = BodyType.DYNAMIC;
		bd.position.set(box2d.coordPixelsToWorld(x,y));
		body = box2d.createBody(bd);

        vUpper = new ArrayList <Vec2> ();
        vLower = new ArrayList <Vec2> ();

		for(int i = 0 ; i <= 150 ; i+= 25) {

			float a = radius * cos(radians(i));
			float b = -radius * sin(radians(i));
			vUpper.add(new Vec2(a, b));

		}

		  vUpper.add(new Vec2(0, 0));


		Vec2[] vUp = new Vec2[vUpper.size()];

		for(int i = 0 ; i < vUpper.size() ; i++) {

			vUp[i] = box2d.vectorPixelsToWorld(vUpper.get(i));
		}

		for(int i = 0 ; i <= 150 ; i+= 25) {

			float a = radius * cos(radians(i));
			float b = radius * sin(radians(i));
			vLower.add(new Vec2(a, b));

		}

		  vLower.add(new Vec2(0, 0));


		Vec2[] vLw = new Vec2[vLower.size()];

		for(int i = 0 ; i < vLower.size() ; i++) {

			vLw[i] = box2d.vectorPixelsToWorld(vLower.get(i));
		}




		PolygonShape ps = new PolygonShape();
		ps.set(vUp, vUp.length);

		PolygonShape pl = new PolygonShape();
		pl.set(vLw, vLw.length);

		body.createFixture(ps, 1);
		body.createFixture(pl, 1);


	}


	void draw() {


		Vec2 pos = box2d.getBodyPixelCoord(body);
		float angle = body.getAngle();
		noStroke();
		fill(175);
		pushMatrix();
		translate(pos.x,pos.y);
		rotate(-angle);
		beginShape();
		for(Vec2 v : vUpper) {

			vertex(v.x, v.y);


		}
		endShape(CLOSE);
		beginShape();
		for(Vec2 v : vLower) {

			vertex(v.x, v.y);


		}
		endShape(CLOSE);
		stroke(0);
		strokeWeight(radius/10);
		point(0, -radius/5);
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
