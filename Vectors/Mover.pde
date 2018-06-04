class Mover {

	PVector position;
	PVector velocity;
	PVector acceleration;

	Mover() {

		position = new PVector(random(0, width), random(0, height));
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);

	}

	void update() {


		PVector mousePos = new PVector(mouseX, mouseY);
		acceleration = PVector.sub(mousePos, position);

		//float mag = acceleration.mag();


		acceleration.normalize();

		//acceleration.mult(1/(mag + 1));

		acceleration.mult(0.5);

		//acceleration.x = position.x - mouseX;
		//acceleration.y = position.y - mouseX;

		velocity.add(acceleration);
		//velocity.limit(10);
		position.add(velocity);
	}

	void show() {

		stroke(0);
		fill(255);
		ellipse(position.x, position.y, 24, 24);

	}


};

Mover m;
Mover m2;

void setup() {
	size(600,400);
	m = new Mover();
	m2 = new Mover();
}

void draw() {

	background(0);

	m.show();
	m.update();

	m2.show();
	m2.update();
}
