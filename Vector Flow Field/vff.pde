
class Particle {
	Vector position;
	Vector velocity;
	Vector acceleration;
	float maxSpeed;
	Vector previous;
	int h = 0;

	Particle() {

	position = new Vector(random(width), random(height));
	velocity = new Vector();
	acceleration = new Vector();
	maxSpeed = 0.5;
	previous = new Vector(position);
	}

	void updatePrevious() {
		this.previous.x = this.position.x;
		this.previous.y = this.position.y;
	}

	void update() {
		updatePrevious();
		this.velocity.add(this.acceleration);
		this.position.add(this.velocity);
		if(this.velocity.getMagnitude() > this.maxSpeed) {
			this.velocity.setMagnitude(this.maxSpeed);
		}
		
		if(this.position.x > width) {
			this.position.x = 0;
			updatePrevious();
		}
		if(this.position.x < 0) {
			this.position.x = width;
			updatePrevious();
		}

		if(this.position.y > height) {
			this.position.y = 0;
			updatePrevious();
		}
		if(this.position.y < 0) {
			this.position.y = height;
			updatePrevious();
		}


		this.acceleration.multiply(0);
	}

	void applyForce(Vector v) {
		this.acceleration.add(v);
	}

	void show() {
		//strokeWeight(2);
		stroke(h, 255, 255, 5);
		if(h == 255) {
			h = 0;
		} else {
			h++;
		}
		line(this.previous.x, this.previous.y, this.position.x, this.position.y);
		//point(this.position.x,this.position.y);
	}



}

// I implemented my own vector class as an exercise
// There's a vector class already available in Processing called PVector

class Vector {
	float x;
	float y;

	Vector(float x, float y) {
		this.x = x;
		this.y = y;
	}

	Vector(Vector v) {
		this.x = v.x;
		this.y = v.y;
	}

	Vector(float angle) {
		this.x = cos(angle);
		this.y = sin(angle);
	}

	Vector() {
		this.x = 0;
		this.y = 0;
	}


	void add(Vector v) {
		this.x += v.x;
		this.y += v.y;
	}

	float getAngle() {
		return atan2(y,x);
	}

	void setAngle(float angle) {
		float magnitude = getMagnitude();
		this.x = magnitude * cos(angle);
		this.y = magnitude * sin(angle);

	}

	float getMagnitude() {
		return sqrt(x * x + y * y);
	}

	void setMagnitude(float mag) {
		float magnitude = this.getMagnitude();
		this.x = (x/magnitude) * mag;
		this.y = (y/magnitude) * mag;
	}

	void multiply(float num) {
		this.x *= num;
		this.y *= num;
	}

};

int scale = 20;
Vector[][] vectors;
Particle[] particles;
int cols, rows;
float xoff = 0;
float yoff = 0;
float zoff = 0;

void setup() {

	size(600,400, P3D);
	colorMode(HSB, 255);
	rows = width / scale + 1;
	cols = height / scale + 1;
	vectors = new Vector[rows][cols];
	particles = new Particle[3000];
	for(int i = 0 ; i < particles.length ; i++) {
		particles[i] = new Particle();
	}
    background(0,0,0,255);
}

void draw() {

	yoff = 0;
	for(int i = 0 ; i < rows ; i++) {
		xoff = 0;
		for(int j = 0 ; j < cols ; j++) {
			float noise = (noise(xoff, yoff, zoff) * PI * 4);
			vectors[i][j] = new Vector(noise);
			vectors[i][j].setMagnitude(0.5);
			// stroke(0);
			// int x1 = i * scale;
			// int y1 = j * scale;
			// float angle = vectors[i][j].getAngle();
			// int x2 = (int)(x1 + (scale * cos(angle)));
			// int y2 = (int)(y1 + (scale * sin(angle)));
			// strokeWeight(0);
			// line(x1, y1, x2, y2);
			xoff += 0.1;
		}
		yoff += 0.1;
	}
	zoff += 0.01;
	for(int i = 0 ; i < particles.length ; i++) {
		int x = floor(particles[i].position.x/scale);
		int y = floor(particles[i].position.y/scale);
		particles[i].applyForce(vectors[x][y]);
		particles[i].show();
		particles[i].update();
	}
}
