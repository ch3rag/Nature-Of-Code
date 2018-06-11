class Surface {

	ArrayList <Vec2> surface;

	Surface() {

		surface = new ArrayList <Vec2>();

		// surface.add(new Vec2(0, height/2));
		// surface.add(new Vec2(100,height/2 + 100));
		// surface.add(new Vec2(200, height/2 - 50));
		// surface.add(new Vec2(width, height/2));

		//SINE WAVE
		float xoff = 0.0;

		// for(int i = 0 ; i < width ; i+= 5) {

		// 	float y = height/2 + 100 * sin(xoff);
		// 	xoff += 0.05;
		// 	surface.add(new Vec2(i,y));


		// }

		//Perlin Noise

		for(int i = 0 ; i < width ; i+= 5) {

			float y = map(noise(xoff),0,1, height/2-100, height/2+200);
			xoff += 0.05;
			surface.add(new Vec2(i,y));


		}



		ChainShape cs = new ChainShape();

		Vec2[] surfaceWorld = new Vec2[surface.size()];

		for(int i = 0 ; i < surface.size() ; i++) {

			surfaceWorld[i] = box2d.coordPixelsToWorld(surface.get(i));


		}

		cs.createChain(surfaceWorld, surfaceWorld.length);

		BodyDef bd = new BodyDef();
		Body body = box2d.world.createBody(bd);
		body.createFixture(cs, 1);

	}

	void draw() {


		stroke(0);
		noFill();
		strokeWeight(1);
		beginShape();
		for(Vec2 v : surface) {

			vertex(v.x,v.y);		

		}

		endShape();
	}
}