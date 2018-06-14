import java.util.*;

class Particle {

	PVector position;
	PVector velocity;
	PVector acceleration;
	int lifespan;

	Particle(float x, float y) {

		position = new PVector(x, y);
		velocity = new PVector(random(-2,2), random(-1,1));
		acceleration = new PVector(0,0);
		lifespan = 255;
	}

	void update() {

		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0);
		lifespan -= 2;

	}

	void applyForce(PVector force) {

		acceleration.add(force);

	}

	void draw() {

		noStroke();
		fill(175, lifespan);
		rect(position.x, position.y,5,5);

	}

	boolean isDead() {

		return lifespan < 0;

	}

}


class Confetti extends Particle {

	Confetti(float x, float y) {
		super(x,y);
	}

	void draw() {

		float angle = map(position.x, 0 , width, 0 , TWO_PI);
		stroke(0,lifespan);
		fill(255,0,0,lifespan);
		pushMatrix();
			translate(position.x, position.y);
			rotate(angle);
			rect(0, 0, 5, 5);
		popMatrix();
	}
}



class ParticleSystem {

	ArrayList <Particle> particles;
	boolean intact = true;
	PVector origin;
	
	ParticleSystem(float x, float y) {

		particles = new ArrayList <Particle>();
		origin = new PVector(x, y);

	}

	void run() {

		float randomNum = random(1);

		if(randomNum < 0.5) {
			particles.add(new Particle(origin.x, origin.y));
		} else {
			particles.add(new Confetti(origin.x, origin.y));
		}

		Iterator <Particle> i = particles.iterator();
		while(i.hasNext()) {

			Particle p = i.next();
			p.draw();
			p.update();
			if(p.isDead()) {
				i.remove();
			}
		}
	}

	void applyForce(PVector force) {

		for(Particle p : particles) {

			p.applyForce(force);
		
		}
	}
}


ParticleSystem s;
PVector gravity = new PVector(0,0.1);

void mousePressed() {


	PVector turbulance = new PVector(random(-1, 1), random(0, 1));
	s.applyForce(turbulance);

}

void setup() {

	size(640,360);
	s = new ParticleSystem(width/2, height/2);
	rectMode(CENTER);
}


void draw() {

	background(0);
	s.run();
	s.applyForce(gravity);

}
