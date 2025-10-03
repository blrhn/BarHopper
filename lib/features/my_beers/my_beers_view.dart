import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/ui_config.dart';
import '../../core/database/beer_type.dart';
import '../../core/database/providers/review_provider.dart';
import 'legend.dart';

class MyBeersView extends ConsumerStatefulWidget {
  const MyBeersView({super.key});

  @override
  ConsumerState<MyBeersView> createState() => _MyBeersViewState();
}

class _MyBeersViewState extends ConsumerState<MyBeersView> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final beerCounts = ref.watch(beerTypeCountProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(UIMyBeersConfig.appBarText),
        centerTitle: true,
      ),
      body: switch (beerCounts) {
        AsyncData(:final value) => Padding(
          padding: const EdgeInsets.all(UIMyBeersConfig.paddingHorizontal),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: UIMyBeersConfig.aspectRation,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!
                              .touchedSectionIndex;
                        });
                      },
                    ),
                    sectionsSpace: UIMyBeersConfig.sectionSpace,
                    centerSpaceRadius: UIMyBeersConfig.centerSpaceRadius,
                    sections: _showSections(value),
                  ),
                ),
              ),
              Legend(beerCounts: value, touchedIndex: touchedIndex),
              const SizedBox(height: UIMyBeersConfig.sizedBoxHeight),
              Text(
                "${UIMyBeersConfig.totalText}${_getAllBeers(value)}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        AsyncError(:final error) => Text("${UIMyBeersConfig.statsError}$error"),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  List<PieChartSectionData> _showSections(Map<BeerType, int> beerCounts) {
    final entries = beerCounts.entries.toList();

    return List.generate(entries.length, (i) {
      final isTouched = i == touchedIndex;
      final entry = entries[i];

      return PieChartSectionData(
        color: UIMyBeersConfig.chartColours(entry.key),
        value: entry.value.toDouble(),
        title: "${entry.value}",
        radius: isTouched
            ? UIMyBeersConfig.touchedRadius
            : UIMyBeersConfig.unTouchedRadius,
        titleStyle: const TextStyle(
          fontSize: UIMyBeersConfig.touchedFontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }

  int _getAllBeers(Map<BeerType, int> beerCounts) {
    return beerCounts.values.fold(0, (sum, count) => sum + count);
  }
}
