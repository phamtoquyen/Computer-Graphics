public class Ray {
  
  PVector origin;
  PVector direction;
  
  public Ray(PVector origin, PVector direction) {
    this.origin = origin;
    this.direction = direction;
  }
  
  //Given a t value, compute R(t) = o + t * d
  public PVector at(float t) {
    return PVector.add(this.origin, PVector.mult(this.direction, t));
  }
}

public class Material {
  PVector difColor;
  PVector ambColor;
  PVector specColor;
  float specPow;
  float kRefl;
  
  public Material(PVector difColor, PVector ambColor, PVector specColor, float specPow, float kRefl) {
    this.difColor = difColor;
    this.ambColor = ambColor;
    this.specColor = specColor;
    this.specPow = specPow;
    this.kRefl = kRefl;
  }
}

public class Light {
  PVector pos;
  PVector col;
  
  public Light(PVector pos, PVector col) {
    this.pos = pos;
    this.col = col;
  } 
}

/* Upon a ray hitting the shape, store the calculated root (t-value),
 * the actual intersection point for the ray and the shape, the normal vector,
 * and the shape that was hit (for shading purposes)
 */
public class Hit {
  PVector norm;
  PVector interPoint;
  float t;
  Shape hitShape;
  
  public Hit(float t, PVector interPoint, PVector norm, Shape hitShape) {
    this.t = t;
    this.interPoint = interPoint;
    this.norm = norm;
    this.hitShape = hitShape;
  }
}

//Parent class for Sphere and Triangle
public abstract class Shape {
  Material mat;
  
  public Shape(Material mat) {
    this.mat = mat;
  }
  
  public abstract Hit intersectRay(Ray ray);
}

public class Sphere extends Shape {
  float radius;
  PVector center;
  Material mat;
  
  public Sphere(float radius, PVector center, Material mat) {
    super(mat);
    this.radius = radius;
    this.center = center;
  }
  
  public Hit intersectRay(Ray ray) {
    // Check if the ray is intersecting with the given sphere. Returns null if no intersection.
    // ===== (TODO) Stage 3b begins =======
    
    //Get vector from the center to the origin
    PVector origRelCenter = PVector.sub(ray.origin, this.center);
    PVector rayDirection = ray.direction;
    PVector rayOrigin = ray.origin;
    
    // First, you need to calculate quadratic coefficients
    float a = rayDirection.dot(rayDirection);
    float b = 2 * (origRelCenter.dot(rayDirection));
    float c = origRelCenter.dot(origRelCenter) - pow(this.radius, 2);
    
    // You need to compute discriminant and handles the cases properly. Returns null if there is no colission.
    float discriminant = pow(b, 2) - (4 * a * c);
    if (discriminant < 0 || a == 0) return null;
    // Compute two "t" values, and return the smallest positive out of the two.
    float t1 = (-b + sqrt(discriminant))/(2 * a);
    float t2 = (-b - sqrt(discriminant))/(2 * a);
    float t = min(t1, t2);
    
    float interX = rayOrigin.x + t * rayDirection.x;
    float interY = rayOrigin.y + t * rayDirection.y;
    float interZ = rayOrigin.z + t * rayDirection.z;
    
    PVector intersectionPoint = new PVector(interX, interY, interZ);  // compute the intersection point using Ray equation. (hint: use Ray.at function)
    PVector sphereNorm = PVector.sub(intersectionPoint, this.center).normalize(); // If you know the collision point, you can compare it against the center of the sphere to compute the norm. Don't forget to normalize this before return.
    // ===== (TODO) Stage 3b ends =======
    return new Hit(t, intersectionPoint, sphereNorm, this);
  }
  
}
