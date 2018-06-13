import org.jbox2d.common.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.*;
import shiffman.box2d.*;
import org.jbox2d.dynamics.joints.*;
import java.util.ArrayList;
import java.util.Iterator;


Box2DProcessing box2d;


Bridge bridge;
ArrayList <Box> boxes = new ArrayList <Box> ();

void setup() {

	size(640, 480);
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0,-10);
	bridge = new Bridge(width, width/8);

}




void draw() {


	background(255);
	box2d.step();
	bridge.draw();
	if(mousePressed) {
  
		boxes.add(new Box(mouseX, mouseY, random(10, 20), random(10, 20)));

	}

	Iterator <Box> i = boxes.iterator();

	while(i.hasNext()) {

		Box b = i.next();
		b.draw();
		if(b.killBody()) {
			i.remove();
		}
	}
}
