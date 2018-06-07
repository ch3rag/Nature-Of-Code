class Draggable {

	PVector position;
	float diameter;
	boolean rollover;
	PVector drag;
	boolean dragging;

	Draggable() {

		position = new PVector(width/2, height/2);
		diameter = 50;
		drag = new PVector(0,0);	
	}

	void draw() {
		stroke(0);
		if(dragging) {
			fill(100);
		} else if(rollover) {
			fill(200);
		} else {
			fill(175);
		}
		ellipse(position.x, position.y, diameter, diameter);
	}
	
	void rollover() {
		float distance = dist(position.x,position.y,mouseX,mouseY);
		rollover =  (distance < diameter/2);
	}

	void clicked() {

		float distance = dist(position.x,position.y,mouseX,mouseY);
		if(distance < diameter/2) {
			dragging = true;
			drag.x = position.x - mouseX;
			drag.y = position.y - mouseY;;
			} else {
			dragging = false;
		}
	}

	void drag() {

		if(dragging) {
			position.x = drag.x + mouseX;
			position.y = drag.y + mouseY;
		}

	}

}

Draggable d;

void setup() {
	size(640,360);
	d = new Draggable();
}

void mousePressed() {
	d.clicked();
}

void mouseReleased() {
	d.dragging = false;
}
void draw() {

	background(255);
	d.draw();
	d.rollover();
	d.drag();
}
