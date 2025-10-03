import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../features/pubs/domain/entities/beer_entry.dart';
import 'beer_type.dart';
import 'pub_review_with_beers.dart';
import 'tables/beer_db.dart';
import 'tables/pub_review_db.dart';

part "review_database.g.dart";

@DriftDatabase(tables: [BeerDb, PubReviewDb])
class ReviewDatabase extends _$ReviewDatabase {
  ReviewDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: "pub_review");
  }

  Future<int> insertReview({
    required String pubId,
    required DateTime visitDate,
    required double rating,
  }) async {
    return await into(pubReviewDb).insert(
      PubReviewDbCompanion(
        pubId: Value(pubId),
        visitDate: Value(visitDate),
        rating: Value(rating),
      ),
    );
  }

  Future<void> insertBeerToReview({
    required int pubReviewId,
    required List<BeerEntry> beers,
  }) async {
    return batch((b) {
      final companions = beers
          .map(
            (beer) => BeerDbCompanion.insert(
              pubReviewId: pubReviewId,
              beerType: beer.beerType,
              notes: Value(beer.notesController.text),
            ),
          )
          .toList();

      b.insertAll(beerDb, companions);
    });
  }

  Future<void> updateReview({
    required int reviewId,
    required DateTime visitDate,
    required double rating,
    required List<BeerEntry> beers,
  }) async {
    return transaction(() async {
      await (update(
        pubReviewDb,
      )..where((tbl) => tbl.id.equals(reviewId))).write(
        PubReviewDbCompanion(
          visitDate: Value(visitDate),
          rating: Value(rating),
        ),
      );

      await (delete(
        beerDb,
      )..where((tbl) => tbl.pubReviewId.equals(reviewId))).go();

      if (beers.isNotEmpty) {
        final companions = beers
            .map(
              (beer) => BeerDbCompanion.insert(
                pubReviewId: reviewId,
                beerType: beer.beerType,
                notes: Value(beer.notesController.text),
              ),
            )
            .toList();

        await batch((b) => b.insertAll(beerDb, companions));
      }
    });
  }

  Future<List<PubReviewWithBeers>> getReview(String pubId) async {
    final reviews = await (select(
      pubReviewDb,
    )..where((tbl) => tbl.pubId.equals(pubId))).get();
    List<PubReviewWithBeers> result = [];
    for (final review in reviews) {
      final beers = await (select(
        beerDb,
      )..where((tbl) => tbl.pubReviewId.equals(review.id))).get();
      result.add(PubReviewWithBeers(review: review, beers: beers));
    }

    return result;
  }

  Future<Map<BeerType, int>> getBeerTypesCount() async {
    final Map<BeerType, int> beerTypeCounts = {};
    final allBeers = await select(beerDb).get();

    for (final beer in allBeers) {
      beerTypeCounts[beer.beerType] = (beerTypeCounts[beer.beerType] ?? 0) + 1;
    }

    return beerTypeCounts;
  }
}
