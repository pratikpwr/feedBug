import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';

enum IconType {
  png,
  svg,
  urlPng,
}

class IconItem extends StatelessWidget {
  const IconItem(
    this.path, {
    Key? key,
    this.size = 18,
    this.color,
    this.type = IconType.png,
  }) : super(key: key);

  final String path;
  final double size;
  final Color? color;
  final IconType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case IconType.png:
        return Image.asset(
          path,
          height: size,
          width: size,
          color: color,
          fit: BoxFit.cover,
        );
      case IconType.svg:
        return Image.asset(
          path,
          height: size,
          width: size,
          color: color,
          fit: BoxFit.cover,
        );
      case IconType.urlPng:
        return CachedNetworkImage(
          imageUrl: path,
          height: size,
          width: size,
          color: color,
          fit: BoxFit.cover,
        );
      default:
        return const SizedBox();
    }
  }
}
