import 'dart:math' as Math;

double bound01(double n, double max) {
  n = max == 360.0 ? n : Math.min(max, Math.max(0.0, n));
  final double absDifference = n - max;
  if (absDifference.abs() < 0.000001) {
    return 1.0;
  }

  if (max == 360) {
    return (n < 0 ? n % max + max : n % max) / max;
  } else {
    return (n % max) / max;
  }
}

double clamp01(double val) => Math.min(1.0, Math.max(0.0, val));
