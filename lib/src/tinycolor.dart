import 'dart:math' as Math;
import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';
import 'package:pigment/pigment.dart';

import 'conversion.dart';
import 'hsl_color.dart';
import 'util.dart';

export 'hsl_color.dart';
export 'color_extension.dart';

class TinyColor {
  Color originalColor;
  Color _color;

  TinyColor(Color color) {
    this.originalColor =
        Color.fromARGB(color.alpha, color.red, color.green, color.blue);
    this._color =
        Color.fromARGB(color.alpha, color.red, color.green, color.blue);
  }

  factory TinyColor.fromRGB({
    @required int r,
    @required int g,
    @required int b,
    int a = 100,
  }) => TinyColor(Color.fromARGB(a, r, g, b));

  factory TinyColor.fromHSL(HslColor hsl) => TinyColor(hslToColor(hsl));

  factory TinyColor.fromHSV(HSVColor hsv) => TinyColor(hsv.toColor());

  factory TinyColor.fromString(String string) => TinyColor(Pigment.fromString(string));

  bool isDark() => getBrightness() < 128.0;

  bool isLight() => !isDark();

  double getBrightness() => (_color.red * 299 + _color.green * 587 + _color.blue * 114) / 1000;

  double getLuminance() => _color.computeLuminance();

  TinyColor setAlpha(int alpha) {
    _color = _color.withAlpha(alpha);
    return this;
  }

  TinyColor setOpacity(double opacity) {
    _color = _color.withOpacity(opacity);
    return this;
  }

  HSVColor toHsv() => colorToHsv(_color);

  HslColor toHsl() {
    final hsl = rgbToHsl(
      r: _color.red.toDouble(),
      g: _color.green.toDouble(),
      b: _color.blue.toDouble(),
    );
    return HslColor(
      h: hsl.h * 360,
      s: hsl.s,
      l: hsl.l,
      a: _color.alpha.toDouble(),
    );
  }

  TinyColor clone() => TinyColor(_color);

  TinyColor lighten([int amount = 10]) {
    final hsl = this.toHsl();
    hsl.l += amount / 100;
    hsl.l = clamp01(hsl.l);
    return TinyColor.fromHSL(hsl);
  }

  TinyColor brighten([int amount = 10]) {
    final color = Color.fromARGB(
      _color.alpha,
      Math.max(0, Math.min(255, _color.red - (255 * -(amount / 100)).round())),
      Math.max(
          0, Math.min(255, _color.green - (255 * -(amount / 100)).round())),
      Math.max(0, Math.min(255, _color.blue - (255 * -(amount / 100)).round())),
    );
    return TinyColor(color);
  }

  TinyColor darken([int amount = 10]) {
    final hsl = toHsl();
    hsl.l -= amount / 100;
    hsl.l = clamp01(hsl.l);
    return TinyColor.fromHSL(hsl);
  }

  TinyColor tint([int amount = 10]) => mix(
    input: Color.fromRGBO(255, 255, 255, 1.0),
    amount: amount,
  );

  TinyColor shade([int amount = 10]) => mix(
    input: Color.fromRGBO(0, 0, 0, 1.0),
    amount: amount,
  );

  TinyColor desaturate([int amount = 10]) {
    final hsl = toHsl();
    hsl.s -= amount / 100;
    hsl.s = clamp01(hsl.s);
    return TinyColor.fromHSL(hsl);
  }

  TinyColor saturate([int amount = 10]) {
    final hsl = toHsl();
    hsl.s += amount / 100;
    hsl.s = clamp01(hsl.s);
    return TinyColor.fromHSL(hsl);
  }

  TinyColor greyscale() => desaturate(100);

  TinyColor spin(double amount) {
    final hsl = toHsl();
    final hue = (hsl.h + amount) % 360;
    hsl.h = hue < 0 ? 360 + hue : hue;
    return TinyColor.fromHSL(hsl);
  }

  TinyColor mix({
    @required Color input,
    int amount = 50,
  }) {
    final p = amount / 100.0;
    final color = Color.fromARGB(
        ((input.alpha - _color.alpha) * p + _color.alpha).round(),
        ((input.red - _color.red) * p + _color.red).round(),
        ((input.green - _color.green) * p + _color.green).round(),
        ((input.blue - _color.blue) * p + _color.blue).round());
    return TinyColor(color);
  }

  TinyColor complement() {
    final hsl = toHsl();
    hsl.h = (hsl.h + 180) % 360;
    return TinyColor.fromHSL(hsl);
  }

  Color get color => _color;
}
