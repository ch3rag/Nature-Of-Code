class Cluster {

	ArrayList <Node> nodes;
	float diameter;

	Cluster(int num, float diameter, Vec2D center) {

		nodes = new ArrayList <Node> ();
		this.diameter = diameter;

		for(int i = 0 ; i < num ; i++) {
			Node n = new Node(center.add(Vec2D.randomVector()));
			nodes.add(n);
			physics.addParticle(n);

		}

		int length = nodes.size();

		for(int i = 0 ; i < length - 1; i++) {

			Node ni = nodes.get(i);

			for(int j = i+1 ; j < length ; j++) {

				Node nj = nodes.get(j);
				physics.addSpring(new VerletSpring2D(ni, nj, diameter, 0.001));

			}
		}
	}


	void draw() {

		for(int i = 0 ; i < nodes.size() - 1; i++) {
			Node ni = nodes.get(i);
			 for(int j = i + 1; j < nodes.size(); j++) {
				Node nj = nodes.get(j);
				strokeWeight(2);
				stroke(0,100);
				line(ni.x,ni.y, nj.x, nj.y);

			}
		}

		for(Node n : nodes) {
			n.draw();
		}

	}
}
