public class PVectorD {
  double x, y, z;

  public PVectorD() {
    set(0, 0, 0);
  }

  public PVectorD(double xx, double yy) {
    set(xx, yy);
  }

  public PVectorD(double xx, double yy, double zz) {
    set(xx, yy, zz);
  }

  public PVectorD(PVector p) {
    set(p);
  }

  public PVectorD(PVectorD p) {
    set(p);
  }

  public PVectorD(int[] a) {
    set(float(a));
  }

  public PVectorD(float[] a) {
    set(a);
  }

  public PVectorD(double[] a) {
    set(a);
  }

  public void clear() {
    x = y = z = 0;
  }

  public void set(double xx, double yy) {
    x = xx;
    y = yy;
  }

  public void set(double xx, double yy, double zz) {
    x = xx;
    y = yy;
    z = zz;
  }

  public void set(PVectorD p) {
    x = p.x;
    y = p.y;
    z = p.z;
  }

  public void set(PVector p) {
    x = p.x;
    y = p.y;
    z = p.z;
  }

  public void set(int[] a) {
    set(float(a));
  }

  public void set(float[] a) {
    final int len = a.length;

    if (len > 0) x = a[0];
    if (len > 1) y = a[1];
    if (len > 2) z = a[2];
  }

  public void set(double[] a) {
    final int len = a.length;

    if (len > 0) x = a[0];
    if (len > 1) y = a[1];
    if (len > 2) z = a[2];
  }

  public PVectorD get() {
    return new PVectorD(x, y, z);
  }

  double mag() {
    return Math.sqrt(x * x + y * y + z * z);
  }

  public PVectorD normalize() {
    double mag = mag();
    x /= mag;
    y /= mag;
    z /= mag;
    return this;
  }

  public PVectorD add(PVectorD p) {
    x += p.x;
    y += p.y;
    z += p.z;
    return this;
  }

  public PVectorD add(PVectorD p1, PVectorD p2) {
    return new PVectorD(p1.x + p2.x, p1.y + p2.y, p1.z + p2.z);
  }

  public PVectorD sub(PVectorD p) {
    x -= p.x;
    y -= p.y;
    z -= p.z;
    return this;
  }

  public PVectorD sub(PVectorD p1, PVectorD p2) {
    return new PVectorD(p1.x - p2.x, p1.y - p2.y, p1.z - p2.z);
  }

  public PVectorD mult(double d) {
    x *= d;
    y *= d;
    z *= d;
    return this;
  }

  public PVectorD mult(PVectorD p, double d) {
    return new PVectorD(p.x * d, p.y * d, p.z * d);
  }

  public PVectorD div(double d) {
    x /= d;
    y /= d;
    z /= d;
    return this;
  }

  public PVectorD div(PVectorD p, double d) {
    return new PVectorD(p.x / d, p.y / d, p.z / d);
  }

  double dist(PVectorD p1, PVectorD p2) {
    return Math.sqrt(Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2) + Math.pow(p1.z - p2.z, 2));
  }

  public void invert() {
    double tempX = x;
    x = y;
    y = tempX;
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
