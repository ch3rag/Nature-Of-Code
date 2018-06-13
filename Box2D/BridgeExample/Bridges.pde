class Bridge {

	ArrayList <Circle> circles;
	float numPoints;
	float length;

	Bridge(float length, float numPoints) {

		this.length = length;
		this.numPoints = numPoints;
		float len = length/numPoints;

		circles = new ArrayList <Circle>();
		Circle c = null,pCircle = c;

		for(int i = 0 ; i <= numPoints + 1 ; i++) {

			pCircle = c;
			c = null;


			if(i == 0 || i == numPoints + 1) {

				c = new Circle(i * len,height/2, true);

			} else {

				c = new Circle(i * len, height/2, false);
			}

			if(i > 0) {

				DistanceJointDef dfd = new DistanceJointDef();
				dfd.bodyA = pCircle.body;
				dfd.bodyB = c.body;
				dfd.length = box2d.scalarPixelsToWorld(len);
				dfd.frequencyHz = 0;
				dfd.dampingRatio = 1;
				DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(dfd);



			}

			circles.add(c);

		}


	}


	void draw() {

		//stroke(0);
		//strokeWeight(4);
		for(int i = 0 ; i < circles.size() - 1; i++) {
			circles.get(i).draw();
			// Vec2 pos1 = box2d.getBodyPixelCoord(circles.get(i).body);
			// Vec2 pos2 = box2d.getBodyPixelCoord(circles.get(i+1).body);
			// line(pos1.x, pos1.y, pos2.x, pos2.y);
		}

	}

}
