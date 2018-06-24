class Turtle {

	float angle;
	float length;
	String todo;

	Turtle(String s, float len, float ang) {
		todo = s;
		length = len;
		angle = ang;
	}

	void changeLen(float factor) {
		length *= factor;
	}

	void setTodo(String s) {
		todo = s;
	}

	void render() {
		if(todo == null) return;
		for(int i = 0 ; i < todo.length() ; i++) {
			char c = todo.charAt(i);
			if(c == 'F') {
				line(0,0,length,0);
				translate(length,0);
			} else if(c == 'G') {
				translate(length, 0);
			} else if(c == '+') {
				rotate(angle);
			} else if(c == '-') {
				rotate(-angle);
			} else if(c == '[') {
				pushMatrix();
			} else if(c == ']') {
				popMatrix();
			}
		}
	}

}
