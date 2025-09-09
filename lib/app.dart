import 'package:flutter/material.dart';
import 'package:move_ela/shared/theme/app_theme.dart';

import 'core/router/app_router.dart';

class MoveElaApp extends StatelessWidget {
  const MoveElaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.instance.router;
    return MaterialApp.router(
      title: 'MoveEla',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}