import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;


VerletPhysics2D physics;
Cloth c;

void setup() {


	size(640, 480);
	physics = new VerletPhysics2D();
	physics.setWorldBounds(new Rect(0,0,width,height));
	physics.addBehavior(new GravityBehavior(new Vec2D(0,0.5)));
	c = new Cloth(width/2 - 100, 10, 200, 300);


}

void draw() {

	background(255);
	physics.update();
	c.draw();
}	
