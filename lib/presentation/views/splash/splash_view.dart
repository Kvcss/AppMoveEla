// lib/presentation/views/splash/splash_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/splash_viewmodel.dart';
import '../../widgets/brand_wave_header.dart';
import '../../widgets/brand_logo_static.dart';
import '../../widgets/brand_loading_bar.dart';
import '../../widgets/logo_with_loader.dart';

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
      context.read<SplashViewModel>().init(context); // 3s -> /login
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // fundo leve (fica bom no light e dark)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [cs.background, cs.surface.withOpacity(.55)],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: BrandWaveHeader(height: 280),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30),
                  LogoWithLoader(
                    asset: 'assets/images/logo.png',
                    logoWidth: 380,
                    gap: 8,
                    barWidth: 200,
                    barHeight: 6,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
