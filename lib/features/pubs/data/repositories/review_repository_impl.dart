import '../../../../core/database/beer_type.dart';
import '../../../../core/database/pub_review_with_beers.dart';
import '../../../../core/database/review_database.dart';
import '../../domain/entities/beer_entry.dart';
import '../../domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewDatabase _db;

  const ReviewRepositoryImpl(this._db);

  @override
  Future<Map<BeerType, int>> getBeerTypesCount() async {
    return _db.getBeerTypesCount();
  }

  @override
  Future<List<PubReviewWithBeers>> getReviewsForPub(String pubId) async {
    return _db.getReview(pubId);
  }

  @override
  Future<void> saveReview({
    required bool isEditing,
    required String pubId,
    required DateTime visitDate,
    required double rating,
    required List<BeerEntry> beers,
    int? reviewId,
  }) async {
    if (isEditing) {
      await _db.updateReview(
        reviewId: reviewId!,
        visitDate: visitDate,
        rating: rating,
        beers: beers,
      );
    } else {
      final reviewId = await _db.insertReview(
        pubId: pubId,
        visitDate: visitDate,
        rating: rating,
      );

      await _db.insertBeerToReview(pubReviewId: reviewId, beers: beers);
    }
  }
}
