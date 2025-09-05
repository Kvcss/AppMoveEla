import 'package:flutter/material.dart';

class BrandWaveHeader extends StatelessWidget {
  const BrandWaveHeader({super.key, this.height = 260});
  final double height;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _WavePainter(color)),
    );
  }
}

class _WavePainter extends CustomPainter {
  _WavePainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..lineTo(0, size.height * .65)
      ..quadraticBezierTo(size.width * .25, size.height * .40, size.width * .55, size.height * .58)
      ..quadraticBezierTo(size.width * .88, size.height * .78, size.width, size.height * .52)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
