import '../../../../core/database/beer_type.dart';
import '../../../../core/database/pub_review_with_beers.dart';
import '../entities/beer_entry.dart';

abstract class ReviewRepository {
  Future<List<PubReviewWithBeers>> getReviewsForPub(String pubId);
  Future<Map<BeerType, int>> getBeerTypesCount();
  Future<void> saveReview({
    required bool isEditing,
    required String pubId,
    required DateTime visitDate,
    required double rating,
    required List<BeerEntry> beers,
    int? reviewId,
  });
}
