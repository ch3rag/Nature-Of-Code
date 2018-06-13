import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;


ArrayList <Cluster> clusters = new ArrayList <Cluster> ();
int n = 5;
VerletPhysics2D physics;
void setup() {
		
	size(640, 480);
	physics = new VerletPhysics2D();
	physics.setWorldBounds(new Rect(0, 0, width, height));

	for(int i = 0 ; i < n ; i++) {

		clusters.add(new Cluster((int)random(3,8), random(20,100), new Vec2D(width/2, height/2)));

	}

	for(int i = 0 ; i < clusters.size() - 1 ; i++) {
		for(int j = i+1 ; j < clusters.size(); j++) {
			clusters.get(i).connect(clusters.get(j));
		}
	}

}

void draw() {
	
	background(255);
	physics.update();
	for(Cluster c : clusters) {
		c.showNodes();
		c.showConnections();
		for(Cluster c_ : clusters) {
			c.showConnections(c_);
		}

	}	

}
