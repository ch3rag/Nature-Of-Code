import java.util.*;

class Particle {

	PVector position;
	PVector velocity;
	PVector acceleration;
	int lifespan;

	Particle(float x, float y) {

		position = new PVector(x, y);
		velocity = new PVector(random(-2, 2), random(1, 3));
		acceleration = new PVector(0,0.1);
		lifespan = 255;
	}

	void update() {

		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0);
		lifespan -= 2;


	}

	void draw() {

		noStroke();
		fill(175, lifespan);
		rectMode(CENTER);
		rect(position.x, position.y,5,5);

	}

	boolean isDead() {

		return lifespan < 0;

	}





}

class ParticleSystem {

	ArrayList <Particle> particles;
	boolean intact = true;

	
	ParticleSystem(int rows, int cols, float x, float y) {

		particles = new ArrayList <Particle>();

		for(int i = 0 ; i < rows ; i++) {
			for(int j = 0 ; j < cols ; j++) {

				particles.add(new Particle(x + j * 5, y + i * 5));

			}
		}

	}

	void run() {


		Iterator <Particle> i = particles.iterator();

		while(i.hasNext()) {

			Particle p = i.next();
			p.draw();
			if(!intact) {

				p.update();

			}

			if(p.isDead()) {

				i.remove();

			}
		}
	}
}


ParticleSystem s;

void mousePressed() {

	s.intact = false;

}

void setup() {

	size(640,360);
	s = new ParticleSystem(20,20,100,100);

}


void draw() {

	background(0);
	s.run();

}
