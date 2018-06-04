int radius = 20;
int boxWidth  = 200;
float angle = 0;
PVector position;
PVector velocity = new PVector(5, 3, 2);

void setup() {

	size(630, 480, P3D);
	position = new PVector(0, 0, 0);


}

void draw() {

	background(0);
	lights();
	noFill();

	translate(width/2, height/2);
	rotateY(angle);

	stroke(255);

	box(boxWidth);
 	translate(position.x, position.y, position.z);

 	sphere(radius);

	position.add(velocity);

	print(position.x + "\n");

	 if(position.x >= boxWidth/2 - radius) {
	 	position.x = boxWidth/2 - radius - 1;
	 	velocity.x *= -1;
	 } else if (position.x <= -boxWidth/2 + radius) {
	 	position.x = -boxWidth/2 + radius + 1;
	 	velocity.x *= -1;
	 }

	 if(position.y >= boxWidth/2 - radius) {
	 	position.y = boxWidth/2 - radius - 1;
	 	velocity.y *= -1;
	 } else if (position.y <= -boxWidth/2 + radius) {
	 	position.y = -boxWidth/2 + radius + 1;
	 	velocity.y *= -1;
	 }

	 if(position.z >= boxWidth/2 - radius) {
	 	position.z = boxWidth/2 - radius - 1;
	 	velocity.z *= -1;
	 } else if (position.z <= -boxWidth/2 + radius) {
	 	position.z = -boxWidth/2 + radius + 1;
	 	velocity.z *= -1;
	 }


 	angle += 0.001;
 }
