class Particle extends VerletParticle2D {

	Particle(Vec2D pos) {

		super(pos);
	}

	void draw() {
		pushMatrix();
		fill(175);
		stroke(0);
		ellipse(x, y, 34, 34);
		popMatrix();
	}

}


void connect (Particle p1, Particle p2, float restLength, float strength) {

	VerletSpring2D spring = new VerletSpring2D(p1,p2, restLength, strength);
	physics.addSpring(spring);

}


class Cloth {

	Particle[][] particles;
	int cols;
	int rows;
	float x;
	float y;
	int width_;
	int height_;
	int scale;
	float strength;




	Cloth(float x, float y, int width_, int height_) {

		this.x = x;
		this.y = y;
		this.width_ = width_;
		this.height_ = height_;

		scale = 10;
		strength = 0.5;
		rows = width_/scale;
		cols = height_/scale;


		particles = new Particle[cols][rows];

		for(int i = 0 ; i < cols ; i++) {
			for(int j = 0 ; j < rows ; j++) {

				Particle p = new Particle(new Vec2D(x + j * scale, y + i * scale));
				particles[i][j] = p;
				physics.addParticle(p);

			}
		}

		for(int i = 0 ; i < cols ; i++) {

			for(int j = 0 ; j < rows ; j++) {

				if(i > 0) {

					connect(particles[i][j], particles[i-1][j], scale, strength);

				}

				if(i < cols - 1) {

					connect(particles[i][j], particles[i+1][j], scale, strength);

				}

				if(j > 0) {

					connect(particles[i][j], particles[i][j-1], scale, strength);

				}

				if(j < rows - 1) {

					connect(particles[i][j], particles[i][j+1], scale, strength);

				}

			}

		}

		particles[0][0].lock();
		particles[0][rows-1].lock();

	}

	void draw() {

		for(int i = 0 ; i < cols ; i++) {

			for(int j = 0 ; j < rows ; j++) {

				if(i > 0) {
					line(particles[i][j].x, particles[i][j].y, particles[i-1][j].x, particles[i-1][j].y);
				}

				if(i < cols - 1) {

					line(particles[i][j].x, particles[i][j].y, particles[i+1][j].x, particles[i+1][j].y);
				}

				if(j > 0) {

					line(particles[i][j].x, particles[i][j].y, particles[i][j-1].x, particles[i][j-1].y);

				}

				if(j < rows - 1) {

					line(particles[i][j].x, particles[i][j].y, particles[i][j+1].x, particles[i][j+1].y);

				}

			}
		}
	}

}
