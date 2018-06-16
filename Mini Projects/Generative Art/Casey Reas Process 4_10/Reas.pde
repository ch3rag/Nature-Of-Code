
//PRESS MOUSE BUTTON TO START

ArrayList <Element> elements = new ArrayList <Element> ();
boolean  start = false;

void setup() {

	size(800, 800);
	for(int i = 0 ; i < 150 ; i++) {
		//PROCESS 4
		elements.add(new Element(random(width), random(height), 40, 70));
		//PROCESS 10
		//elements.add(new Element(width/2, height/2, 30, 50));
	}
	background(0);
	colorMode(HSB);
}

void mousePressed() {
	start = true;
}

void draw() {
	//background(0);
	if(start) {

	  for(Element e : elements) {
		  e.run();
		  e.applyBehavior(elements);
	  }
  }
}
