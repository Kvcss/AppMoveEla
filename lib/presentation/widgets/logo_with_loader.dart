// lib/presentation/widgets/logo_with_loader.dart
import 'package:flutter/material.dart';
import 'brand_logo_static.dart';
import 'brand_loading_bar.dart';

class LogoWithLoader extends StatelessWidget {
  const LogoWithLoader({
    super.key,
    required this.asset,
    this.logoWidth = 240,
    this.gap = 10,
    this.barWidth = 190,
    this.barHeight = 6,
  });

  final String asset;
  final double logoWidth;
  final double gap;
  final double barWidth;
  final double barHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BrandLogoStatic(asset: asset, width: logoWidth),
        SizedBox(height: gap),
        BrandLoadingBar(width: barWidth, height: barHeight),
      ],
    );
  }
}