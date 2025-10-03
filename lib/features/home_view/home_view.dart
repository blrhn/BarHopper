import 'package:bar_hop/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../core/config/ui_config.dart';
import '../map/map_view.dart';
import 'settings_dialog.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      appBar: AppBar(
        title: const Text(MyAppConfig.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showSettings(context),
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: const MapView(),
    );
  }

  void _showSettings(BuildContext context) {
    SettingsDialog.show(context);
  }
}
