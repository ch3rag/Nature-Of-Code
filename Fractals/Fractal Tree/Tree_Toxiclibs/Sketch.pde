import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
import java.util.ArrayList;

VerletPhysics2D physics;
float angle = PI/6;
ArrayList <Particle> particles = new ArrayList <Particle> ();
VerletParticle2D mouseAttractor = new VerletParticle2D(new Vec2D(0,0));

void setup() {

	size(640, 480);
	physics = new VerletPhysics2D();
	physics.setWorldBounds(new Rect(0,0, width, height));
	physics.addBehavior(new GravityBehavior(new Vec2D(0,-0.2)));
	Particle root = new Particle(new Vec2D(width/2, height), null);
	root.lock();
	particles.add(root);
	physics.addParticle(root);
	branch(width/2, height, 100, 0, root);
	physics.addBehavior(new AttractionBehavior(mouseAttractor,50,10));
	physics.addParticle(mouseAttractor);
	noFill();
	physics.update();
}


void draw() {
	
	background(255);
	for(int i = 0 ; i < particles.size() - 1 ; i++) {
		Particle p1 = particles.get(i);
		Particle p2 = particles.get(i).parent;
		if(p2 != null) {
			line(p1.x, p1.y, p2.x, p2.y);
		}
	}

	mouseAttractor.x = mouseX;
	mouseAttractor.y = mouseY;
	ellipse(mouseAttractor.x, mouseAttractor.y, 20, 20);
	physics.update();
}


void branch(float x, float y, float length, float angle_, Particle parent) {

	float xl = x + length * cos(-angle_ - PI/2);
	float yl = y + length * sin(-angle_ - PI/2);
	Particle p = new Particle(new Vec2D(xl,yl), parent);
	VerletSpring2D spring = new VerletSpring2D(parent, p, length, 1);
	physics.addParticle(p);
	physics.addSpring(spring);
	particles.add(p);

	length *= 0.75;
	if(length < 10) {
		return;
	} else {

		branch(xl, yl, length, angle_ + angle, p);
		branch(xl, yl, length, angle_ - angle, p);

	}

}

