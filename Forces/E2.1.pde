Using forces, simulate a helium-filled balloon floating upward and bouncing off the
top of a window. Can you add a wind force that changes over time, perhaps
according to Perlin noise?

class Balloon {
	PVector position;
	PVector velocity;
	PVector acceleration;

	Balloon() {
	
		position = new PVector(width/2, height/2); 
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);

	}

	void update() {

		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0);
		if(position.y <= 30) {
			velocity.y *= -1;
		}


	}
	
	void applyForce(PVector force) {
		acceleration.add(force);
	}

	void draw() {

		stroke(255);
		fill(255,0,0,255);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, 40, 60);
		line(position.x, position.y + 30, position.x, position.y + 60);
	}

};

Balloon b;
PVector wind;
PVector upthrust;
float xoff = 0;

void setup() {

	size(640, 360);
	b = new Balloon();
	upthrust = new PVector(0, -0.1);
	wind = new PVector(0,0);
}

void draw() {

	background(0);

	b.draw();
	b.applyForce(upthrust);
	wind.x = map(noise(xoff),0,1,-0.001,0.001);
	wind.y = map(noise(xoff*3),0,1,-0.001,0.001);
	b.applyForce(wind);
	b.update();
	translate(width/2, height - 20);
	rotate(wind.heading());
	line(0,0,30,0);
	xoff += 0.01;

}
