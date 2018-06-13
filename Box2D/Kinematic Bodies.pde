import org.jbox2d.common.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.*;
import shiffman.box2d.*;
import org.jbox2d.dynamics.joints.*;
import java.util.ArrayList;
import java.util.Iterator;


Box2DProcessing box2d;

KinematicBox b;

void setup() {

	size(640, 480);
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0,-10);
	b = new KinematicBox(width/2, height/2, 30,30);
}




void draw() {

	background(255);
	box2d.step();
	b.draw();
	b.bind(mouseX,mouseY);
}
