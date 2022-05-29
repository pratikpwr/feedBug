import 'package:flutter/material.dart';

import '../../errors/failure_types.dart';

class FailureView extends StatelessWidget {
  const FailureView({
    Key? key,
    required this.type,
  }) : super(key: key);

  final FailureType type;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(type.message),
    );
  }
}
