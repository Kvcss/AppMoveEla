import 'package:flutter/material.dart';
import 'brand_logo_static.dart';

/// Logo central com "breathing/pulse" bem sutil.
class AnimatedPulseLogo extends StatefulWidget {
  const AnimatedPulseLogo({
    super.key,
    required this.asset,
    this.width = 280,
    this.height,
    this.scaleMin = 1.0,
    this.scaleMax = 1.035,
    this.duration = const Duration(milliseconds: 1500),
    this.logoColor,
  });

  final String asset;
  final double width;
  final double? height;
  final double scaleMin;
  final double scaleMax;
  final Duration duration;
  final Color? logoColor; // opcional (aplica "tint" se seu SVG permitir)

  @override
  State<AnimatedPulseLogo> createState() => _AnimatedPulseLogoState();
}

class _AnimatedPulseLogoState extends State<AnimatedPulseLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    _scale = Tween<double>(begin: widget.scaleMin, end: widget.scaleMax)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (_, __) {
        return Transform.scale(
          scale: _scale.value,
          child: BrandLogoStatic(
            asset: widget.asset,
            width: widget.width,
            height: widget.height,
            color: widget.logoColor,
          ),
        );
      },
    );
  }
}
