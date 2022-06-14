import 'package:flutter/material.dart';
import 'package:setuback/src/core/extension/context_extension.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(0),
    this.margin,
    this.onTap,
  }) : super(key: key);

  final Widget child;

  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.theme.colorScheme.secondaryContainer,
        // boxShadow: [
        //   BoxShadow(
        //     color: context.theme.colorScheme.shadow.withOpacity(0.15),
        //     blurRadius: 8,
        //     spreadRadius: 0,
        //     offset: const Offset(0, 0),
        //   ),
        // ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
