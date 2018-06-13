import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import java.util.ArrayList;
import java.util.Iterator;




ArrayList <Diamond> diamonds;
Box2DProcessing box2d;
Boundary bn2,bn;



void setup() {
	size(640, 360);

	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0,-10); //SETS DEFAULT GRAVITY

	bn = new Boundary(180,height/2 + 20,300,10, radians(20));
	bn2 = new Boundary(width - 180,height-80,300,10, radians(-20));

	diamonds = new ArrayList <Diamond> ();

}


void draw() {
	background(255);

	box2d.step();
	 
	 bn.draw();
	 bn2.draw();

	if(mousePressed) {

		diamonds.add(new Diamond(mouseX, mouseY));

	}

	Iterator <Diamond> k = diamonds.iterator();

	while(k.hasNext()) {

		Diamond d = k.next();
		d.draw();
		if(d.killBody()) {

			k.remove();

		}

	 }

}
