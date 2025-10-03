import 'package:flutter/material.dart';

import '../../../../core/database/beer_type.dart';

class BeerEntry {
  final BeerType beerType;
  TextEditingController notesController;

  BeerEntry({required this.beerType, String? notes = ""})
    : notesController = TextEditingController(text: notes);

  BeerEntry copyWith({BeerType? beerType, String? notes}) {
    return BeerEntry(
      beerType: beerType ?? this.beerType,
      notes: notes ?? notesController.text,
    );
  }
}
