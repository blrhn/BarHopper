import 'package:bar_hop/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../map/map_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      appBar: AppBar(title: const Text("BarHop"), centerTitle: true,),
      body: const MapView(),
    );
  }
}
