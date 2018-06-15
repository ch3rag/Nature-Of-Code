class FlowField {

  PVector[][] vectors;
  int rows;
  int cols;
  int resolution;
  float xOff = 0;
  float yOff = 0;
  float zOff = 0;
  
  //DRAW PARAMETERS PRECALCULATED FOR BETTER PERFORMANCE

  float offset;
  float aYOffset;
  float aXOffset;

  FlowField(int resolution) {

    this.resolution = resolution;
    rows = (int)height / resolution;
    cols = (int)width / resolution;

    offset = resolution / 2;
    aYOffset = offset * 0.25;
    aXOffset = offset * 0.5;


    vectors = new PVector[rows][cols];

    for(int i = 0 ; i < rows ; i++) { //INITIALIZES THE FLOW FIELD USING PERLIN NOISE
      xOff = 0;
      for(int j = 0 ; j < cols ; j++) {
        float angle = map(noise(xOff,yOff,zOff), 0, 1, 0,TWO_PI * 2);
        vectors[i][j] = PVector.fromAngle(angle);
        xOff += 0.1;
      }
      yOff += 0.1;
    }
  }


  PVector lookup(PVector lookup) {

    int row = (int) constrain(lookup.y/resolution, 0, rows - 1);
    int col = (int) constrain(lookup.x/resolution, 0, cols - 1);
    return vectors[row][col].get();

  }

  //3D Perlin Noise (Performance Overhead)
  // Updates complete field when called

  void updateFlowField() { 
    
    yOff = 0;
    for(int i = 0 ; i < rows ; i++) {
      xOff = 0;
      for(int j = 0 ; j < cols ; j++) {
        float angle = map(noise(xOff,yOff,zOff), 0, 1, 0,TWO_PI * 2);
        vectors[i][j] = PVector.fromAngle(angle);
        xOff += 0.1;
      }
      yOff += 0.1;
    } 
    zOff += 0.03;
  }

  void draw() {

    for(int i = 0 ; i < rows ; i++) {
      for(int j = 0 ; j < cols ; j++) {
        pushMatrix();
        stroke(0,75);
        translate(j * resolution + offset, i * resolution + offset);
        rotate(vectors[i][j].heading());
        line(-offset, 0, offset,0);
        line(offset,0,aXOffset, aYOffset);
        line(offset,0,aXOffset, -aYOffset);
        popMatrix();
      }
    }
  }
}
