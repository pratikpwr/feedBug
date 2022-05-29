import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './src/app.dart';
import './src/core/app/bloc_providers.dart';
import './src/core/app/injection_container.dart' as di;

void main() {
  di.init();
  runApp(MultiBlocProvider(
    providers: getBlocProviders(),
    child: const MyApp(),
  ));
}
