import 'package:flutter/material.dart';

import '../../core/config/ui_config.dart';
import '../../core/database/beer_type.dart';

class Legend extends StatelessWidget {
  final Map<BeerType, int> beerCounts;
  final int touchedIndex;

  const Legend({
    super.key,
    required this.beerCounts,
    required this.touchedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final entries = beerCounts.entries.toList();
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: UIMyBeersConfig.wrapSpacing,
      runSpacing: UIMyBeersConfig.wrapRunSpacing,
      children: List.generate(entries.length, (i) {
        final entry = entries[i];
        final isTouched = i == touchedIndex;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.circle, color: UIMyBeersConfig.chartColours(entry.key)),
            const SizedBox(width: UIMyBeersConfig.sizedBoxWidth),
            Text(
              entry.key.label,
              style: TextStyle(
                fontWeight: isTouched ? FontWeight.bold : FontWeight.normal,
                fontSize: isTouched
                    ? UIMyBeersConfig.touchedFontSize
                    : UIMyBeersConfig.untouchedFontSize,
              ),
            ),
          ],
        );
      }),
    );
  }
}
