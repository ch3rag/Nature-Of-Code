LSystem lsys;
Turtle turtle;

void setup() {
	size(800,800);
	Rule[] ruleset = new Rule[1];
	ruleset[0] = new Rule('F', "FF+[+F-F-F]-[-F+F+F]");
	lsys = new LSystem("F", ruleset);
	turtle = new Turtle(lsys.getSentence(), width/4, radians(25));
}




void draw() {
	
	background(255);
	translate(width/2, height);
	rotate(-PI/2);
	turtle.render();
	noLoop();

}

void mousePressed() {
	lsys.generate();
	turtle.setTodo(lsys.getSentence());
	turtle.changeLen(0.5);
	redraw();
}
