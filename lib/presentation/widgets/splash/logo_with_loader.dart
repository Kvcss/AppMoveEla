import 'package:flutter/material.dart';
import 'brand_logo_static.dart';
import 'brand_loading_bar.dart';

class LogoWithLoader extends StatelessWidget {
  const LogoWithLoader({
    super.key,
    required this.asset,
    this.logoWidth = 240,
    this.gap = 4,          // gap pequeno para aproximar o loader do logo
    this.barWidth = 190,
    this.barHeight = 6,
    this.logoColor,
  });

  final String asset;
  final double logoWidth;
  final double gap;
  final double barWidth;
  final double barHeight;
  final Color? logoColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BrandLogoStatic(asset: asset, width: logoWidth, color: logoColor),
        SizedBox(height: gap),
        BrandLoadingBar(width: barWidth, height: barHeight),
      ],
    );
  }
}
