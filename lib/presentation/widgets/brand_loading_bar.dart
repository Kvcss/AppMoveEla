import 'package:flutter/material.dart';

class BrandLoadingBar extends StatefulWidget {
  const BrandLoadingBar({super.key, this.width = 160, this.height = 6, this.duration = const Duration(milliseconds: 1100)});
  final double width;
  final double height;
  final Duration duration;

  @override
  State<BrandLoadingBar> createState() => _BrandLoadingBarState();
}

class _BrandLoadingBarState extends State<BrandLoadingBar> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final track = Theme.of(context).colorScheme.onSurface.withOpacity(.08);
    final accent = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.height),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: track), // trilho
            AnimatedBuilder(
              animation: _ctrl,
              builder: (_, __) {
                final w = widget.width * .38;              // largura do “pincel”
                final x = (widget.width + w) * _ctrl.value - w;
                return Transform.translate(
                  offset: Offset(x, 0),
                  child: Container(
                    width: w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [accent.withOpacity(.0), accent, accent.withOpacity(.0)],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
