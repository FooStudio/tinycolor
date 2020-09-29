import 'dart:ui';

import 'util.dart';

class HslColor {
  final double h;
  final double s;
  final double l;
  final double a;

  HslColor({this.h, this.s, this.l, this.a = 0.0});

  Color toColor() {
    double r;
    double g;
    double b;
    final double h = bound01(this.h, 360.0);
    final double s = bound01(this.s * 100, 100.0);
    final double l = bound01(this.l * 100, 100.0);

    if (s == 0.0) {
      r = g = b = l;
    } else {
      final q = l < 0.5 ? l * (1.0 + s) : l + s - l * s;
      final p = 2 * l - q;
      r = _hue2rgb(p, q, h + 1 / 3);
      g = _hue2rgb(p, q, h);
      b = _hue2rgb(p, q, h - 1 / 3);
    }
    return Color.fromARGB(a.round(), (r * 255).round(), (g * 255).round(), (b * 255).round());
  }

  double _hue2rgb(double p, double q, double t) {
    if (t < 0) t += 1;
    if (t > 1) t -= 1;
    if (t < 1 / 6) return p + (q - p) * 6 * t;
    if (t < 1 / 2) return q;
    if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
    return p;
  }

  /// Lighten the color a given amount, from 0 to 100.
  /// Providing 100 will always return white.
  HslColor lighten([int amount = 10]) => copyWith(l: clamp01(l + amount / 100));

  /// Darken the color a given amount, from 0 to 100.
  /// Providing 100 will always return black.
  HslColor darken([int amount = 10]) => copyWith(l: clamp01(l - amount / 100));

  /// Desaturate the color a given amount, from 0 to 100.
  /// Providing 100 will is the same as calling greyscale.
  HslColor desaturate([int amount = 10]) => copyWith(s: clamp01(s - amount / 100));

  /// Saturate the color a given amount, from 0 to 100.
  HslColor saturate([int amount = 10]) => copyWith(s: clamp01(s + amount / 100));

  /// Completely desaturates a color into greyscale. Same as calling desaturate(100).
  HslColor greyscale() => desaturate(100);

  /// Spin the hue a given amount, from -360 to 360.
  /// Calling with 0, 360, or -360 will do nothing (since it sets the hue back to what it was before).
  HslColor spin(double amount) {
    final hue = (h + amount) % 360;
    return copyWith(h: hue < 0 ? 360 + hue : hue);
  }

  HslColor complement() => copyWith(h: (h + 180) % 360);

  HslColor copyWith({double h, double s, double l, double a}) {
    return HslColor(h: h ?? this.h, s: s ?? this.s, l: l ?? this.l, a: a ?? this.a);
  }

  String toString() {
    return "HSL(h: $h, s: $s, l: $l, a: $a)";
  }
}
