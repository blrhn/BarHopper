import 'package:drift/drift.dart';

import '../beer_type.dart';
import 'pub_review_db.dart';

class BeerDb extends Table {
  late final beerId = integer().autoIncrement()();
  late final pubReviewId = integer().references(PubReviewDb, #id)();
  late final beerType = textEnum<BeerType>()();
  late final notes = text().nullable()();
}
