import java.util.*;
Random generator;

class Particle {

	PVector position;
	PVector velocity;
	PVector acceleration;
	int lifespan;
	PImage texture;

	Particle(float x, float y) {

		position = new PVector(x, y);
		float vx = (float)generator.nextGaussian() * 0.5;
		float vy = (float)generator.nextGaussian() * 0.3 - 1;
		velocity = new PVector(vx, vy);
		acceleration = new PVector(0,0);
		lifespan = 255;
		texture = loadImage("tex.png");
		texture.resize(30,0);
	}

	void update() {

		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0);
		lifespan -= 5;

	}

	void applyForce(PVector force) {

		acceleration.add(force);

	}

	void draw() {

		fill(0, lifespan);
		image(texture,position.x,position.y);
		
	}

	boolean isDead() {

		return lifespan < 0;

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

		particles.add(new Particle(origin.x, origin.y));
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
PVector gravity = new PVector(0,-0.05);



void setup() {

	size(640,360);
	s = new ParticleSystem(width/2, height-50);;
	rectMode(CENTER);
	generator = new Random();
	blendMode(ADD);
}


void draw() {

	background(0);
	s.run();
	s.applyForce(gravity);

}
