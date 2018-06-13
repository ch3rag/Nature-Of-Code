

class Cluster {

	ArrayList <Node> nodes;
	float diameter;

	Cluster(int num, float diameter, Vec2D center) {

		nodes = new ArrayList <Node> ();
		this.diameter = diameter;

		for(int i = 0 ; i < num ; i++) {
			Node n = new Node(center.add(Vec2D.randomVector()));
			nodes.add(n);


		}

		int length = nodes.size();

		for(int i = 0 ; i < length - 1; i++) {

			Node ni = nodes.get(i);

			for(int j = i+1 ; j < length ; j++) {

				Node nj = nodes.get(j);
				physics.addSpring(new VerletSpring2D(ni, nj, diameter, 0.01));

			}

		}

	}

	void connect (Cluster c) {

		for(Node n : nodes) {
			for(Node n_ : c.nodes) {

				physics.addSpring(new VerletMinDistanceSpring2D(n, n_,(diameter + c.diameter) * 0.5, 0.05));

			}
		}

	}

	void showNodes() {

	for(Node n : nodes) {
			n.draw();
		}

	}

	void showConnections() {

		for(int i = 0 ; i < nodes.size() - 1; i++) {
			Node ni = nodes.get(i);
			 for(int j = i + 1; j < nodes.size(); j++) {
				Node nj = nodes.get(j);
				strokeWeight(2);
				stroke(0,50);
				line(ni.x,ni.y, nj.x, nj.y);

			}
		}
	}

	void showConnections(Cluster c) {

		for(Node n : nodes) {

			for(Node n_ : c.nodes) {

				strokeWeight(2);
				stroke(0,50);
				line(n.x,n.y, n_.x, n_.y);
			}
		}
	}

}
