import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:tinycolor2/tinycolor2.dart';

void main() {
  test(
    "setAlpha updates alpha value of color",
    () {
      TinyColor color = TinyColor(Color(0xFFFFFFFF));
      color.setAlpha(0x00);
      expect(color.color.alpha, 0x00);
    },
  );

  test(
    "setOpacity updates opacity value of color",
    () {
      TinyColor color = TinyColor(Color(0xFFFFFFFF).withOpacity(1.0));
      color.setOpacity(0.5);

      // underlying dart implementation converts the opacity value to an 
      // int, then back into a double. Thus some precision is loss.
      expect(color.color.opacity, moreOrLessEquals(0.5, epsilon: 1e-2));
    },
  );
}
