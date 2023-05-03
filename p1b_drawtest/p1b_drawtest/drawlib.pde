// Drawing Routines that are similar to those in OpenGL
class MyVertex {
  float x;
  float y;
  MyVertex(float _x, float _y) {
    x = _x;
    y = _y;
  }
}

float left, right, bottom, top, near, far; // Saved parameters for gtOrtho
float fov2, near2, far2; // Saved parameters for gtPerspective
boolean do_ortho;
ArrayList<MyVertex> vertices; // a list of vertices in the "screen" coordinate.
Matrix mat_proj; 


void gtOrtho(float _left, float _right, float _bottom, float _top, float _near, float _far) {
  // Save the parameters for gtOrtho
  left = _left;
  right = _right;
  bottom = _bottom;
  top = _top;
  near = _near;
  far = _far;
  do_ortho = true;
}

void gtPerspective(float _fov_in_deg, float _near, float _far) {
  // Save the parameters for gtPerspective
  fov2 = radians(_fov_in_deg);
  near2 = _near;
  far2 = _far;
  do_ortho = false;
}

void gtVertex(float x, float y, float z) {
  // This function takes the 3D point as input and add a projected vertex to the "vertices" list.
  // Please implement the function carefully by following the instruction.

  // We convert the given 3D point into a homogenous coordinate by adding "1" to the end.
  Matrix ptMatrix = new Matrix(4, 1);
  ptMatrix.values[0][0] = x;
  ptMatrix.values[1][0] = y;
  ptMatrix.values[2][0] = z;
  ptMatrix.values[3][0] = 1.0;
  
  // Step 1a. Get the current transformation matrix (in the matrix stack tab) using "get_ctm()" function. It returns the current transformation matrix as Matrix.
  // (TODO) 
  Matrix currentMatrix = get_ctm(); 
  // Step 1b. Compute the transformed point by applying the ctm.  
  // (TODO)
  Matrix transformedMatrix = mat_multiply(currentMatrix, ptMatrix);
  float x_transformed = transformedMatrix.values[0][0];
  float y_transformed = transformedMatrix.values[1][0];
  float z_transformed = transformedMatrix.values[2][0];
   
  if (do_ortho) { // If it is orthogonal projection.
    // Step 2. Project the ptTransformed onto the screen using "orthogonal" projection. You may want to use left, right, top, bottom varaibles.
    // (hint: you may not need to worry about near and far variables because we do not consider depth for now)
    // (TODO)
    float x_projected =  (x_transformed  - left)* (750 / (right - left));
    float y_projected =  (y_transformed - bottom) * (750/(top - bottom));
    System.out.print("ortho: " + x + " " + y + " "+ "->" + x_transformed+ " " + y_transformed + " " + "->" + x_projected + " " + y_projected);
    System.out.println();
    vertices.add(new MyVertex(x_projected, y_projected));
   
  } else {
    // Step 3. Project the ptTransformed onto the screen using "perspective" projection. You can X and Y projection using x,y,z, and near2. 
    // Then convert the point in [-k, k] onto the screen (x in [0, w] and y in [0, h]).
    // (hint: you do not need to use far2 because we ignore the depth)
    // (hint: k is equal to  tan(fov2 / 2))
    // (TODO)
    float x_projected = x_transformed/ Math.abs(z_transformed);
    float y_projected = y_transformed/ Math.abs(z_transformed);
    float k = fov2 / 2.0;
    
    float x_screen = (x_projected + k) * (750 / (2 * k));
    float y_screen = (y_projected + k) * (750 / (2 * k));
    vertices.add(new MyVertex(x_screen, y_screen));
    
  }
}

void gtBeginShape() {
  // A function to initialize the vertices
  vertices = new ArrayList<MyVertex>();
}

void gtEndShape() {
  // When this function is called, we iterate over the vertex list and draw the lines.
  for (int i = 0; i < vertices.size() - 1; i += 2) {
    MyVertex p = vertices.get(i);
    MyVertex q = vertices.get(i + 1);
    line(p.x, height - p.y, q.x, height - q.y);
  }
}
