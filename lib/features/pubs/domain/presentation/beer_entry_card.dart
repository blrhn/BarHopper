import 'package:bar_hop/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/ui_config.dart';
import '../../../../core/database/beer_type.dart';
import '../entities/beer_entry.dart';

class BeerEntryCard extends StatelessWidget {
  final BeerEntry beerEntry;
  final void Function(BeerType?) onTypeChanged;
  final VoidCallback onRemove;

  const BeerEntryCard({
    super.key,
    required this.beerEntry,
    required this.onTypeChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: UIBeerEntryCardConfig.paddingHorizontal,
        ),
        child: Row(
          children: [
            DropdownButton<BeerType>(
              value: beerEntry.beerType,
              items: BeerType.values
                  .map(
                    (type) => DropdownMenuItem<BeerType>(
                      value: type,
                      child: Text(
                        type.label,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onTypeChanged,
            ),
            const SizedBox(width: UIBeerEntryCardConfig.sizedBoxWidth),
            Expanded(
              child: TextField(
                controller: beerEntry.notesController,
                decoration: InputDecoration(
                  label: Text(
                    UIBeerEntryCardConfig.textFieldLabelText,
                    style: TextStyle(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(onPressed: onRemove, icon: const Icon(Icons.remove)),
          ],
        ),
      ),
    );
  }
}
