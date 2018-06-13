import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.joints.*;
import java.util.ArrayList;
import java.util.Iterator;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList <Mover> movers = new ArrayList <Mover> ();
Floor f;

void endContact(Contact cp) {

}

void beginContact(Contact cp) {

	Fixture f1 = cp.getFixtureA();
	Fixture f2 = cp.getFixtureB();
	
	Body b1 = f1.getBody();
	Body b2 = f2.getBody();

	Object o1 = b1.getUserData();
	Object o2 = b2.getUserData();

	if(o1.getClass() == Mover.class && o2.getClass() == Mover.class) {

		Mover m1 = (Mover) o1;
		Mover m2 = (Mover) o2;
		m1.change();
		m2.change();


	}


}

void setup() {

	size(640, 480);
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.listenForCollisions(); //ENABLE CONTANT LISTENER
	box2d.setGravity(0,-10);
	f = new Floor(0, height - 10, width, 10);

}

void mousePressed() {
	movers.add(new Mover(mouseX, mouseY));
 }

void draw() {

	background(255);

	box2d.step();
	f.draw();


	Iterator <Mover> i = movers.iterator();
	while(i.hasNext()) {

		Mover m = i.next();
		m.draw();;
		if(m.killBody()) {

			i.remove();

		}
	}
}
