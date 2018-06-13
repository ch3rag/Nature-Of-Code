import org.jbox2d.common.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.*;
import shiffman.box2d.*;
import org.jbox2d.dynamics.joints.*;
import java.util.ArrayList;
import java.util.Iterator;


Box2DProcessing box2d;

Floor f;
ArrayList <Pair> pairs = new ArrayList <Pair>();


void setup() {

	size(640, 480);
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0,-10);
	f = new Floor(0, height-10, width, 10);

}

void mousePressed() {

	pairs.add(new Pair(mouseX, mouseY));

}


void draw() {

	background(255);
	box2d.step();

	Iterator <Pair> i = pairs.iterator();
	f.draw();
	while(i.hasNext()) {

		Pair p = i.next();
		p.draw();
		if(p.killBody()) {
			i.remove();
		}
	}
}
