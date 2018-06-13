class Pair {

	Circle c1;
	Circle c2;
	float restLength = 30;

	Pair(float x, float y) {

		c1 = new Circle(x,y,false);
		c2 = new Circle(x + random(-1, 1), y + random(-1, 1),false);

		DistanceJointDef djd = new DistanceJointDef();
		djd.bodyA = c1.body;
		djd.bodyB = c2.body;
		djd.length = box2d.scalarPixelsToWorld(restLength);
		djd.frequencyHz = 3;
		djd.dampingRatio = 0.1;

		DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);

	}


	void draw() {

		Vec2 pos1 = box2d.getBodyPixelCoord(c1.body);
		Vec2 pos2 = box2d.getBodyPixelCoord(c2.body);
		stroke(0);
		line(pos1.x, pos1.y, pos2.x, pos2.y);
		c1.draw();
		c2.draw();

	}

	boolean killBody() {

		Vec2 pos = box2d.getBodyPixelCoord(c1.body);
		if(pos.x > width || pos.y > width) {

			box2d.destroyBody(c1.body);
			box2d.destroyBody(c2.body);
			return true;
		} 

		return false;
	}

	


}
