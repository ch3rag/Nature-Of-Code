class Windmill {

	Box support;
	Box rotor;

	Windmill(float x, float y, int dir) {

		rotor = new Box(x, y - 25, 150, 10, false);
		support = new Box(x, y, 10, 50, true);

		RevoluteJointDef rjd = new RevoluteJointDef();
		rjd.initialize(support.body, rotor.body, box2d.coordPixelsToWorld(new Vec2(x, y - 25)));

		rjd.enableMotor = true;
		rjd.maxMotorTorque = 10000;
		rjd.motorSpeed = PI * 6 * dir;

		RevoluteJoint rj = (RevoluteJoint) box2d.world.createJoint(rjd);


	}


	void draw() {

		support.draw();
		rotor.draw();


	}

}
