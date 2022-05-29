import 'package:flutter/material.dart';
import 'package:setuback/src/core/themes/theme_data.dart';
import 'package:setuback/src/features/projects/screens/projects_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeConfig.themeFromSeed,
      home: const ProjectsScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('help'),
    );
  }
}
