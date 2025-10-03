import "package:drift/drift.dart";

class PubReviewDb extends Table {
  late final id = integer().autoIncrement()();
  late final pubId = text()();
  late final visitDate = dateTime()();
  late final rating = real()();
}
