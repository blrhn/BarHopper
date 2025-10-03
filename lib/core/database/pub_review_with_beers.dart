import 'review_database.dart';

class PubReviewWithBeers {
  final PubReviewDbData review;
  final List<BeerDbData> beers;

  PubReviewWithBeers({required this.review, required this.beers});
}
