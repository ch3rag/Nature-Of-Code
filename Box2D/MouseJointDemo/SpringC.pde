class Spring {

	MouseJoint mj;

	Spring() {

		mj = null;

	}

	void bind(Box b, float x, float y) {

		MouseJointDef mjd = new MouseJointDef();
		mjd.bodyA = box2d.getGroundBody();
		mjd.bodyB = b.body;
		mjd.target.set(box2d.coordPixelsToWorld(x,y));
		mjd.maxForce = 5000;
		mjd.frequencyHz = 60;
		mjd.dampingRatio = 0;
		mj = (MouseJoint) box2d.world.createJoint(mjd);
		
	}

	void destroy() {

		if(mj != null) {
			
			box2d.world.destroyJoint(mj);
			mj = null;

		}

	}


	void update(float x, float y) {

		if(mj != null) {

			Vec2 target = box2d.coordPixelsToWorld(x,y);
			mj.setTarget(target);

		}

	}

}
