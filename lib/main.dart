import 'package:bar_hop/core/config/ui_config.dart';
import 'package:bar_hop/core/router/app_router.dart';
import 'package:bar_hop/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = AppTheme();

    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: MyAppConfig.title,
      theme: appTheme.light,
    );
  }
}
