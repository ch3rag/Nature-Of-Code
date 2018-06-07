class Car {

	PVector position;
	PVector velocity;
	PVector acceleration;
	float angle = 0;

	Car() {

		position = new PVector(width/2, height/2);
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);
		

	} 

	void draw() {
		stroke(0);
		fill(175);
		translate(position.x, position.y);
		rotate(angle);
		triangle(0, -10, 25, 0, 0, 10);
	}

	void update() {

		velocity.add(acceleration);
		velocity.limit(5);
		position.add(velocity);
		acceleration.mult(0);

	}

	void applyForce(PVector force) {

		acceleration.add(force);

	}
}


Car car;

void keyPressed() {
	PVector acceleration = PVector.fromAngle(car.angle);


	if(keyCode == UP) {
		car.applyForce(acceleration);
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

void setup() {
	size(800,800);
	car = new Car();
}

void draw() {

	background(0);
	car.draw();
	car.update();


}
