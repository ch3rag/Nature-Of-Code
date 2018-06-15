// FLOW FIELD CLASS THAT GENERATES FLOW FIELD BASED OF BRIGHTNESS OF THE PIXELS OF AN IMAGE

class ImageFlowField extends FlowField {

  PImage image;

  ImageFlowField(int resolution, PImage image) {

    super(resolution);
    this.image = image;
    image.loadPixels();
    for(int i = 0 ; i < rows ; i++) {
      for(int j = 0 ; j < cols ; j++) {

        int x = j * resolution;
        int y = i * resolution;
        int c = image.pixels[x + y * image.width];
        float theta  = map(brightness(c), 0, 255, 0, TWO_PI);
        vectors[i][j] = PVector.fromAngle(theta);
        vectors[i][j].normalize();
      }
    }
  }

  void draw() {

    image(image,0,0);
     super.draw();
  }
}
