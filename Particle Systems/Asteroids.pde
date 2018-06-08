import java.util.*;

class Particle {

	PVector position;
	PVector velocity;
	PVector acceleration;
	float lifespan;
	float angle;
	float aVelocity;

	Particle(PVector origin, PVector direction) {
	
		position = origin.get();
		velocity = direction.get();
		acceleration = new PVector(0,0);
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
			rect(0,0,8,8);

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


class Car {

	PVector position;
	PVector velocity;
	PVector acceleration;
	float angle = 0;
	ArrayList <Particle> particles;

	Car() {

		position = new PVector(width/2, height/2);
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);
		particles = new ArrayList <Particle>();
		

	} 

	void draw() {
		stroke(0);
		fill(175);
		pushMatrix();
		translate(position.x, position.y);
		rotate(angle);
		
		triangle(0, -10, 25, 0, 0, 10);
		rect(0,5,5,5);
		rect(0,-5,5,5);
		popMatrix();

		Iterator <Particle> i = particles.iterator();
		while(i.hasNext()) {
			Particle p = i.next();
			p.run();
			if(p.isDead()) {
				i.remove();
			}
		}
	}

	void update() {

		velocity.add(acceleration);
		velocity.limit(5);
		position.add(velocity);
		acceleration.mult(0);
		if (keyPressed) {
			PVector acceleration = PVector.fromAngle(car.angle);


			if(keyCode == UP) {
				
				car.applyForce(acceleration);
				PVector direction = velocity.get();
				direction.normalize();
				direction.mult(-1);
				direction.rotate(random(-1,1));
				particles.add(new Particle(position, direction));

			} else
			if(keyCode == LEFT) {
				car.angle += -0.1;
				car.velocity.rotate(-0.1);
			} else
			if(keyCode == RIGHT) {
				car.angle += 0.1;
				car.velocity.rotate(0.1);
			} else
			if(keyCode == DOWN) {
				acceleration.mult(-1);
				car.applyForce(acceleration);
			}
		}
	}

	void applyForce(PVector force) {

		acceleration.add(force);

	}
}


Car car;


void setup() {
	size(800,800);
	rectMode(CENTER);
	car = new Car();
}

void draw() {

	background(0);
	car.draw();
	car.update();


}
