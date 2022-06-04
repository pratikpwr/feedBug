import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: child,
    );
  }
}
