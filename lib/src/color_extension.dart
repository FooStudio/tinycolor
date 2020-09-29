import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';
import 'hsl_color.dart';
import 'dart:math' as Math;

import 'util.dart';

/// Extends the Color class to allow direct TinyColor manipulation nativly
extension TinyColorExtension on Color {
  /// Return a boolean indicating whether the color's perceived brightness is dark.
  bool get isDark => brightness < 128.0;

  /// Return a boolean indicating whether the color's perceived brightness is light.
  bool get isLight => brightness >= 128.0;

  /// Returns the perceived brightness of a color, from 0-255, as defined by Web Content Accessibility Guidelines (Version 1.0).
  double get brightness => (red * 299 + green * 587 + blue * 114) / 1000;

  /// Return the perceived luminance of a color, a shorthand for flutter Color.computeLuminance
  double get luminance => computeLuminance();

  HSVColor toHsv() => HSVColor.fromColor(this);

  HslColor toHsl() {
    final r = bound01(red.toDouble(), 255.0);
    final g = bound01(green.toDouble(), 255.0);
    final b = bound01(blue.toDouble(), 255.0);

    final max = [r, g, b].reduce(Math.max);
    final min = [r, g, b].reduce(Math.min);
    double h = 0.0;
    double s = 0.0;
    final double l = (max + min) / 2;

    if (max == min) {
      h = s = 0.0;
    } else {
      final double d = max - min;
      s = l > 0.5 ? d / (2.0 - max - min) : d / (max + min);
      if (max == r) {
        h = (g - b) / d + (g < b ? 6 : 0);
      } else if (max == g) {
        h = (b - r) / d + 2;
      } else if (max == b) {
        h = (r - g) / d + 4;
      }
    }

    h /= 6.0;
    return HslColor(h: h * 360, s: s, l: l, a: alpha.toDouble());
  }

  /// Brighten the color a given amount, from 0 to 100.
  Color brighten([int amount = 10]) {
    return Color.fromARGB(
      alpha,
      Math.max(0, Math.min(255, red - (255 * -(amount / 100)).round())),
      Math.max(0, Math.min(255, green - (255 * -(amount / 100)).round())),
      Math.max(0, Math.min(255, blue - (255 * -(amount / 100)).round())),
    );
  }

  /// Mix the color with pure white, from 0 to 100.
  /// Providing 0 will do nothing, providing 100 will always return white.
  Color tint([int amount = 10]) => mix(input: Color.fromRGBO(255, 255, 255, 1.0));

  /// Mix the color with pure black, from 0 to 100.
  /// Providing 0 will do nothing, providing 100 will always return black.
  Color shade([int amount = 10]) => mix(input: Color.fromRGBO(0, 0, 0, 1.0));

  /// Blends the color with another color a given amount, from 0 - 100, default 50.
  Color mix({@required Color input, int amount = 50}) {
    final int p = (amount / 100).round();
    return Color.fromARGB(
      (input.alpha - alpha) * p + alpha,
      (input.red - red) * p + red,
      (input.green - green) * p + green,
      (input.blue - blue) * p + blue,
    );
  }
}
