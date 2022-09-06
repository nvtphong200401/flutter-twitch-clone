
import 'package:flutter_riverpod/flutter_riverpod.dart';

String convertViewer(int viewer) {
  if (viewer >= 1000) {
    return '${(viewer / 1000).toStringAsFixed(1)} N';
  }
  return viewer.toString();
}
