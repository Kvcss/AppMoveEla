import 'package:flutter/material.dart';

/// Barra de loading simples, arredondada.
class BrandLoadingBar extends StatelessWidget {
  const BrandLoadingBar({
    super.key,
    this.width = 180,
    this.height = 6,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: LinearProgressIndicator(
          value: null,
          minHeight: height,
          backgroundColor: cs.surfaceContainerHighest.withOpacity(.35),
          valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
        ),
      ),
    );
  }
}
