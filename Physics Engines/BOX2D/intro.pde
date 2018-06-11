import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import java.util.ArrayList;
import java.util.Iterator;



//ArrayList <Box> boxes;
ArrayList <Circle> circles;

Box2DProcessing box2d;
Surface s;

//Boundary bn2,bn;



void setup() {
	size(640, 360);

	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0,-10); //SETS DEFAULT GRAVITY
	//boxes = new ArrayList <Box>();
	//bn = new Boundary(180,height/2 + 20,300,10, radians(20));
	//bn2 = new Boundary(width - 180,height-80,300,10, radians(-20));
	s = new Surface();
	circles = new ArrayList <Circle>();

}


void draw() {
	background(255);

	box2d.step();
	 s.draw();
	 //bn.draw();
	 //bn2.draw();
	// Iterator <Box> i = boxes.iterator();

	// while(i.hasNext()) {

	// 	Box b = i.next();
	// 	b.draw();
	// 	if(b.killBody()) {

	// 		i.remove();
		
	// 	}

	// }

	// if(mousePressed) {

	// 	boxes.add(new Box(mouseX, mouseY));
	// }

	if(mousePressed) {

		circles.add(new Circle(mouseX, mouseY));

	}

	Iterator <Circle> j = circles.iterator();

	while(j.hasNext()) {

		Circle c = j.next();
		c.draw();

		if(c.killBody()) {

			j.remove();

		}



	}





}