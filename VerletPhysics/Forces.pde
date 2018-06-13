import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;



ArrayList <Node> nodes = new ArrayList <Node> ();
Attractor a;

VerletPhysics2D physics;
void setup() {
		
	size(640, 640);
	physics = new VerletPhysics2D();
	physics.setWorldBounds(new Rect(0, 0, width, height));
	//physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.5)));
	a = new Attractor(new Vec2D(width/2, height/2));

	

}

void draw() {
	
	background(255);
	physics.update();
	a.draw();
	if(mousePressed) {
		Node n = new Node(new Vec2D(mouseX, mouseY));
		nodes.add(n);
		physics.addParticle(n);
	} 

	for(Node n : nodes) {
		n.draw();
	}
	
}
