import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

Rope s;
VerletPhysics2D physics;
void setup() {

	size(640, 480);
	physics = new VerletPhysics2D();
	physics.setWorldBounds(new Rect(0,0, width, height));
	physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.5)));
	s = new Rope (200, 20);


 }

 void mousePressed() {

 	s.isClicked();
 } 

  void mouseReleased() {

 	s.release();
 } 


 void draw() {
 	background(255);
 	physics.update();
 	s.draw();
 	s.drag();
 }
