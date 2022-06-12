import 'package:flutter/material.dart';

import '../../errors/failure_types.dart';

class FailureView extends StatelessWidget {
  const FailureView({
    Key? key,
    required this.type,
    this.onRetry,
  }) : super(key: key);

  final FailureType type;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(type.message),
          TextButton(
            onPressed: onRetry,
            child: const Text('RETRY'),
          ),
        ],
      ),
    );
  }
}
