// lib/presentation/widgets/brand_logo_static.dart
import 'package:flutter/material.dart';

/// Logo estática com tint. Permite definir width/height separadamente.
/// Ideal para wordmarks (mais larga que alta).
class BrandLogoStatic extends StatelessWidget {
  const BrandLogoStatic({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.color,
  });

  final String asset;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    return ColorFiltered(
      colorFilter: ColorFilter.mode(c, BlendMode.srcIn),
      child: Image.asset(
        asset,
        width: width,
        height: height,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
