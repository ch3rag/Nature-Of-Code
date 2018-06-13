import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
import java.util.ArrayList;

ArrayList <Particle> particles = new ArrayList <Particle> ();

VerletPhysics2D physics;
VerletSpring2D spring;
Particle p1, p2;
void setup() {

	size(640, 480);
	physics = new VerletPhysics2D();
	physics.setWorldBounds(new Rect(0,0,width,height));
	physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.5)));
	p1 = new Particle(new Vec2D(width/2, 20));
	p2 = new Particle(new Vec2D(width/2, 100));
	p1.lock();
	spring = new VerletSpring2D(p1, p2, 80, 0.01);
	physics.addParticle(p1);
	physics.addParticle(p2);
	physics.addSpring(spring);

}

void draw() {

	background(255);

	physics.update();
	line(p1.x, p1.y, p2.x, p2.y);
	p1.draw();
	p2.draw();


	if(mousePressed) {

		p2.lock();

		p2.x = mouseX;
		p2.y = mouseY;
		p2.unlock();

	}

}
