import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;



VerletPhysics2D physics;
Cluster c;
void setup() {
		
	size(640, 480);
	physics = new VerletPhysics2D();
	physics.setWorldBounds(new Rect(0, 0, width, height));
	c = new Cluster(30, 200,new Vec2D(width/2, height/2));


}

void draw() {
	
	background(255);
	physics.update();
	c.draw();


}
