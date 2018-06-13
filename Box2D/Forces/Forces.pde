import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.joints.*;
import java.util.ArrayList;
import java.util.Iterator;

Box2DProcessing box2d;
ArrayList <Mover> movers = new ArrayList <Mover> ();
Attractor a;


void setup() {

	size(640, 480);
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0,0);
	a = new Attractor(width/2, height/2);

}

void mousePressed() {
	movers.add(new Mover(mouseX, mouseY));
}

void draw() {

	background(255);

	box2d.step();
	a.draw();

	Iterator <Mover> i = movers.iterator();
	while(i.hasNext()) {

		Mover m = i.next();
		m.draw();
		a.attract(m);
		if(m.killBody()) {

			i.remove();

		}
	}
}
