import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          fit: BoxFit.fitWidth,
        );
      case IconType.svg:
        return SvgPicture.asset(
          path,
          width: size,
          height: size,
          fit: BoxFit.fitWidth,
          color: color,
        );
      case IconType.urlPng:
        return CachedNetworkImage(
          imageUrl: path,
          height: size,
          width: size,
          color: color,
          fit: BoxFit.fitWidth,
        );
      default:
        return const SizedBox();
    }
  }
}
