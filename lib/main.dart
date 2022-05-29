import 'package:flutter/material.dart';

import './src/app.dart';
import './src/core/app/injection_container.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}
