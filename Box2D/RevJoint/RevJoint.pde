import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.joints.*;
import java.util.ArrayList;
import java.util.Iterator;

Box2DProcessing box2d;
Windmill w,w2;
ArrayList <Box> boxes;


void setup() {


	size(640, 480);
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	w = new Windmill(width/2, height-100,1);
	//w2 = new Windmill(width/2 - 100, height-100,-1);
	boxes = new ArrayList <Box> ();

}


void draw() {

	background(0);
	box2d.step();
	w.draw();
	//w2.draw();

	if(mousePressed) {

		boxes.add(new Box(mouseX, mouseY, random(5,10), random(5,20), false));


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
