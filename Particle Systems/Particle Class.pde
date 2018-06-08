import java.util.ArrayList;
import java.util.Iterator;

class Particle {

	PVector position;
	PVector velocity;
	PVector acceleration;
	float lifespan;
	float angle;
	float aVelocity;

	Particle(PVector origin) {
	
		position = origin.get();
		velocity = new PVector(random(-1,1),random(1, 3));
		acceleration = new PVector(0,1);
		lifespan = 255;
		angle = 0;
		aVelocity = 0.5;
	
	}

	void update() {

		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0);
		lifespan -= 2;
		angle += aVelocity;

	}
	

	void applyForce(PVector force) {

		acceleration.add(force);

	}

	void display() {

		stroke(0,lifespan);
		fill(175,lifespan);
		pushMatrix();

			translate(position.x, position.y);
			rotate(angle);
			rect(0,0,8,10);

		popMatrix();

	}

	void run() {
		
		update();
		display();

	}

	boolean isDead() {
		return lifespan < 0;
	}

}

class ParticleSystem {

	ArrayList <Particle> particals;
	PVector emitter;

	ParticleSystem(float x, float y) {

		emitter = new PVector(x,y);
		particals = new ArrayList <Particle>();

	}

	void run() {

		particals.add(new Particle(emitter));

		Iterator <Particle> i = particals.iterator();

		while(i.hasNext()) {

			Particle p = i.next();
			p.run();

			if(p.isDead()) {
				i.remove();
			}
		}
	}

}

ParticleSystem p;

void setup() {

	size(600,400);
	rectMode(CENTER);
	p = new ParticleSystem(width/2, 10);
}


void draw() {

	background(255);
	p.run();


}
