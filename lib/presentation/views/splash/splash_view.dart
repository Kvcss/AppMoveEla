import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/splash_viewmodel.dart';
import '../../widgets/splash/animated_pulse_logo.dart';

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
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: _ResponsiveLogo()),
    );
  }
}

class _ResponsiveLogo extends StatelessWidget {
  const _ResponsiveLogo();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final logoW = (constraints.maxWidth * .92)
            .clamp(280.0, 720.0)
            .toDouble();
        return AnimatedPulseLogo(
          asset: 'assets/images/logo_svg.svg',
          width: logoW,
          scaleMin: 1.0,
          scaleMax: 1.035,
          duration: const Duration(milliseconds: 1500),
        );
      },
    );
  }
}
