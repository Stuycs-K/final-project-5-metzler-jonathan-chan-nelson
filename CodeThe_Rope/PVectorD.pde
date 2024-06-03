public class PVectorD {
  double x, y, z;

  PVectorD(double xx, double yy) {
    set(xx, yy);
  }

  PVectorD(double xx, double yy, double zz) {
    set(xx, yy, zz);
  }

  PVectorD(PVector p) {
    set(p);
  }
  
  PVectorD(PVectorD p) {
    set(p);
  }

  PVectorD(int[] a) {
    set(float(a));
  }

  PVectorD(float[] a) {
    set(a);
  }

  PVectorD(double[] a) {
    set(a);
  }

  void clear() {
    x = y = z = 0;
  }

  void set(double xx, double yy) {
    x = xx;
    y = yy;
  }

  void set(double xx, double yy, double zz) {
    x = xx;
    y = yy;
    z = zz;
  }
  
  void set(PVectorD p) {
    x = p.x;
    y = p.y;
    z = p.z;
  }

  void set(PVector p) {
    x = p.x;
    y = p.y;
    z = p.z;
  }

  void set(int[] a) {
    set(float(a));
  }

  void set(float[] a) {
    final int len = a.length;

    if (len > 0)  x = a[0];
    if (len > 1)  y = a[1];
    if (len > 2)  z = a[2];
  }

  void set(double[] a) {
    final int len = a.length;

    if (len > 0)  x = a[0];
    if (len > 1)  y = a[1];
    if (len > 2)  z = a[2];
  }

  PVectorD get() {
    return new PVectorD(x, y, z);
  }
  
  double mag() {
    return Math.sqrt(x * x + y * y + z * z);
  }
  
  PVectorD normalize() {
    double mag = mag();
    x /= mag;
    y /= mag;
    z /= mag;
    return this;
  }
  
  PVectorD add(PVectorD p) {
    x += p.x;
    y += p.y;
    z += p.z;
    return this;
  }
  
  PVectorD add(PVectorD p1, PVectorD p2) {
    return new PVectorD(p1.x + p2.x, p1.y + p2.y, p1.z + p2.z);
  }
  
  PVectorD sub(PVectorD p) {
    x -= p.x;
    y -= p.y;
    z -= p.z;
    return this;
  }
  
  PVectorD sub(PVectorD p1, PVectorD p2) {
    return new PVectorD(p1.x - p2.x, p1.y - p2.y, p1.z - p2.z);
  }
  
  PVectorD mult(double d) {
    x *= d;
    y *= d;
    z *= d;
    return this;
  }
  
  PVectorD mult(PVectorD p, double d) {
    return new PVectorD(p.x * d, p.y * d, p.z * d);
  }
  
  PVectorD div(double d) {
    x /= d;
    y /= d;
    z /= d;
    return this;
  }
  
  PVectorD div(PVectorD p, double d) {
    return new PVectorD(p.x / d, p.y / d, p.z / d);
  }
  
  double dist(PVectorD p1, PVectorD p2){
    return Math.sqrt(Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2) + Math.pow(p1.z - p2.z, 2));
  }

  PVector toPVector() {
    return new PVector((float) x, (float) y, (float) z);
  }

  double[] toArray() {
    return new double[] {
      x, y, z
    };
  }

  String toString() {
    return "[ " + x + ", " + y + ", " + z + " ]";
  }
}
