import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Exibe logo (PNG/JPG/SVG) com suporte a tint opcional.
/// - SVG: usa as cores originais; define `logoColor` se quiser tint.
/// - Raster: aplica tint usando ColorFiltered.
class BrandLogoStatic extends StatelessWidget {
  const BrandLogoStatic({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.filterQuality = FilterQuality.high,
  });

  final String asset;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final FilterQuality filterQuality;

  bool get _isSvg => asset.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return SvgPicture.asset(
        asset,
        width: width,
        height: height,
        fit: fit,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    }

    final c = color ?? Theme.of(context).colorScheme.primary;
    return ColorFiltered(
      colorFilter: ColorFilter.mode(c, BlendMode.srcIn),
      child: Image.asset(
        asset,
        width: width,
        height: height,
        fit: fit,
        filterQuality: filterQuality,
      ),
    );
  }
}
