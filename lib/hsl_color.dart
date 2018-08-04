class HSLColor {
  double h;
  double s;
  double l;
  double a;

  HSLColor({this.h, this.s, this.l, this.a = 0.0});

  String toString() {
    return "HSL(h: $h, s: $s, l: $l, a: $a)";
  }
}
