import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/splash_viewmodel.dart';
import '../../widgets/splash/brand_wave_header.dart';
import '../../widgets/splash/logo_with_loader.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashViewModel>().init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topRight,
          //       end: Alignment.bottomLeft,
          //       colors: [cs.background],
          //     ),
          //   ),
          // ),

          // const Align(
          //   alignment: Alignment.topCenter,
          //   child: BrandWaveHeader(height: 280),
          // ),

          SafeArea(
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxW = constraints.maxWidth;
                  final logoWidth = (maxW * .82).clamp(0, 460).toDouble();
                  final barWidth = logoWidth * .73;

                  return LogoWithLoader(
                    asset: 'assets/images/logo_svg.svg',
                    logoWidth: logoWidth,
                    gap: 2,
                    barWidth: barWidth,
                    barHeight: 6,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
