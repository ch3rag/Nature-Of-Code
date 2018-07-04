import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;
import java.util.Iterator;

class Terrain {

	ArrayList <Vec2> verticies;

	Terrain() {

		verticies = new ArrayList <Vec2> ();
		float numVertex = 30;
		float delta = width/numVertex;
		float yoff = 0;
		for(float x = 0 ; x <= (width+1) ; x += delta) {
			float y = map(noise(yoff), 0, 1, height/2, height);
			verticies.add(new Vec2(x, y));
			yoff += 0.1;
		}

		Vec2[] surface = new Vec2[verticies.size()];

		for(int i = 0 ; i < surface.length ; i++) {
			surface[i] = box2d.coordPixelsToWorld(verticies.get(i));
		}

		ChainShape cs = new ChainShape();
		cs.createChain(surface, surface.length);
		BodyDef bd = new BodyDef();
		Body body;
		body = box2d.createBody(bd);
		body.createFixture(cs,1);

	}

	void draw() {
		
		stroke(0);
		strokeWeight(2);
		noFill();

		beginShape();
			for(Vec2 v : verticies) {
				vertex(v.x, v.y);
			}

		endShape();
	}



}
class Box {
	Body body;

	float bW;
	float bH;

	Box(float x, float y, float bWidth, float bHeight) {

		bW = bWidth;
		bH = bHeight;

		BodyDef bd =  new BodyDef();
		bd.type = BodyType.DYNAMIC;
		bd.position.set(box2d.coordPixelsToWorld(x,y));
		body = box2d.createBody(bd);

		PolygonShape ps = new PolygonShape();
		float boxW = box2d.scalarPixelsToWorld(bWidth/2);
		float boxH = box2d.scalarPixelsToWorld(bHeight/2);
		ps.setAsBox(boxW, boxH);

		FixtureDef fd = new FixtureDef();
		fd.shape = ps;
		fd.density = 1;
		fd.restitution = 0.3; 
		fd.friction = 0.5;

		body.createFixture(fd);
	}

	void draw() {
		Vec2 pos = box2d.getBodyPixelCoord(body);
		float angle = body.getAngle();
		pushMatrix();
			strokeWeight(1);
			translate(pos.x, pos.y);
			rotate(-angle);
			rectMode(CENTER);
			fill(175);
			stroke(0);
			rect(0,0,bW, bH);
		popMatrix();
	}

	boolean killBody() {
		Vec2 position = box2d.getBodyPixelCoord(body);
		if(position.x > width || position.x < 0 || position.y > height) {
			box2d.destroyBody(body);
			return true;
		}
		return false;
 	}
}

Box2DProcessing box2d;
ArrayList <Box>  boxes = new ArrayList <Box> ();
Terrain t;

void setup() {
	
	size(800,800);
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0,-10);
	t = new Terrain();
}


void draw() {

	background(255);;
	box2d.step();
	Iterator <Box> i = boxes.iterator();
	while(i.hasNext()) {
		Box b = i.next();
		b.draw();
		if(b.killBody()) {
			i.remove();
		}
	}

	t.draw();

	if(mousePressed) {

		boxes.add(new Box(mouseX, mouseY, random(20,30), random(20,30)));
	}

}
