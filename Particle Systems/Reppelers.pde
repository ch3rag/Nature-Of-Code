import java.util.*;

class Repeller {

	PVector position;
	float G = 50;

	Repeller(float x, float y) {

		position = new PVector(x,y);


	} 

	void draw() {

		fill(175);
		stroke(255);
		ellipse(position.x, position.y, 24, 24);

	}

	PVector repel(Particle p) {

		PVector force = PVector.sub(p.position, position);
		float d = force.mag();
		d = constrain(d, 5, 100);
		force.normalize();
		force.mult(G/(d*d));
		//println(force.mag());
		return force;
	}

}

class Particle {

	PVector position;
	PVector velocity;
	PVector acceleration;
	int lifespan;

	Particle(float x, float y) {

		position = new PVector(x, y);
		velocity = new PVector(random(-0.1,0.1), random(-1,1));
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

	void applyRepeller(Repeller r) {

		for(Particle p : particles) {

			PVector force = r.repel(p);
			p.applyForce(force);

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
Repeller r;


void setup() {

	size(640,360);
	s = new ParticleSystem(width/2, 50);
	r = new Repeller(width/2, height/2);
	rectMode(CENTER);
}


void draw() {

	background(0);
	s.run();
	s.applyForce(gravity);
	s.applyRepeller(r);
	r.draw();

}
