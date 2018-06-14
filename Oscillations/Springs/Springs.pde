class Bob {

	PVector position;
	PVector velocity;
	PVector acceleration;
	float diameter;
	boolean rollover;
	PVector drag;
	boolean dragging;
	
	Bob(float x, float y) {

		position = new PVector(x,y);
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);
		diameter = 25;
		drag = new PVector(0,0);

	}

	void update() {

		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0);

	}

	void applyForce(PVector force) {
		
		acceleration.add(force);

	}

	void draw() {
		stroke(0);
		if(dragging) {
			fill(100);
		} else if(rollover) {
			fill(200);
		} else {
			fill(175);
		}
		ellipse(position.x, position.y, diameter, diameter);
	}

	void rollover() {
		float distance = dist(position.x,position.y,mouseX,mouseY);
		rollover =  (distance < diameter/2);
	}

	void clicked() {

		float distance = dist(position.x,position.y,mouseX,mouseY);
		if(distance < diameter/2) {
			dragging = true;
			drag.x = position.x - mouseX;
			drag.y = position.y - mouseY;;
			} else {
			dragging = false;
		}
	}

	void drag() {

		if(dragging) {
			position.x = drag.x + mouseX;
			position.y = drag.y + mouseY;
		}

	}

}

class Spring {

	PVector anchor;
	float restLength;
	float k;

	Spring(float x, float y, float restLength, float k) {

		anchor = new PVector(x,y);
		this.restLength = restLength;
		this.k = k;

	}

	void constrainLength(Bob b, float minLength, float maxLength) {

		PVector distance = PVector.sub(b.position, anchor);
		float d = distance.mag();

		if (d < minLength) {

			distance.normalize();
			distance.mult(minLength);
			b.position = PVector.add(distance,anchor);
			b.velocity.mult(0);

		} else if(d > maxLength) {

			distance.normalize();
			distance.mult(maxLength);
			b.position = PVector.add(distance,anchor);
			b.velocity.mult(0);

		}



	}

	void connect (Bob b) {

		PVector force = PVector.sub(anchor,b.position);
		float currentLength = force.mag();
		force.normalize();
		float x = restLength - currentLength;
		force.mult(-1 * k * x);
		b.applyForce(force);

	}

	void draw() {

		stroke(0);
		fill(175);
		rect(anchor.x, anchor.y, 10,10);
	}

	void drawLine(Bob b) {

		line(anchor.x, anchor.y, b.position.x, b.position.y);

	}

	
}

Spring s, s2;
Bob bob;
PVector wind = new PVector(1,0);
PVector gravity = new PVector(0,0.1);
void mousePressed() {
	bob.applyForce(wind);
	bob.clicked();
}

void mouseReleased() {
	bob.dragging = false;
}

void keyPressed() {
		if(key == 'r') {
			bob.velocity.mult(0);
			bob.position.x = width/2;
			bob.position.y = height/2;
		}
}



void setup() {

	size(640,360);
	rectMode(CENTER);
   	s = new Spring(width/2 + 100, height/2, 100, 0.05);
	s2 = new Spring(width/2 - 100, height/2, 100, 0.01);
	bob = new Bob(width/2, height/2);
}

void draw() {
	
	background(255);
	s.connect(bob);
	s2.connect(bob);
	s.constrainLength(bob,s.restLength/2,s.restLength*2);
	s2.constrainLength(bob,s2.restLength/2,s2.restLength*2);
	s.drawLine(bob);
	s.draw();
	s2.drawLine(bob);
	s2.draw();
	bob.draw();
	bob.rollover();
	bob.drag();
	bob.applyForce(gravity);
	bob.update();

}
