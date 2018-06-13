class Rope { 

	ArrayList <Particle> particles = new ArrayList <Particle> ();
	Particle tail;
	boolean dragged = false;
	Vec2D offset;



	Rope(float length, int numPoints) {

		float offset = length / numPoints;
		Particle current = null;
		Particle previous;

		for(int i = 0 ; i < numPoints ; i++) {

			previous = current;
			current = new Particle(new Vec2D(width/2 , 10 + i * offset));
			if(i == 0) {

				current.lock();

			}

			if(i > 0) {

				VerletSpring2D spring = new VerletSpring2D(previous, current, offset, 0.06);
				physics.addSpring(spring);
			}

			physics.addParticle(current);
			particles.add(current);

		}

		tail = particles.get(numPoints - 1);

	}

	void draw() {

		strokeWeight(2);
		stroke(0);
		beginShape();

		for(Particle p : particles) {
			vertex(p.x, p.y);
		}
		noFill();
		endShape();
		tail.draw();
		if(dragged) {

			stroke(0,255,0);
			line(mouseX, mouseY, tail.x - offset.x , tail.y - offset.y);

		}
	}

	void isClicked() {

		Vec2D mouse = new Vec2D(mouseX, mouseY);
		Vec2D dir = tail.sub(mouse);
		float dis = dir.magnitude();
		if(dis <= 17) {
			offset = dir;
			dragged = true;
		}
	}

	void drag() {

		if(dragged) {

			tail.lock();
			tail.x = mouseX + offset.x;	
			tail.y = mouseY + offset.y;
			tail.unlock();
		}

	}

	void release() {

		dragged = false;

	}
}
