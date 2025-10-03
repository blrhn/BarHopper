import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/pubs/data/repositories/review_repository_impl.dart';
import '../../../features/pubs/domain/repositories/review_repository.dart';
import '../beer_type.dart';
import '../pub_review_with_beers.dart';
import '../review_database.dart';

part 'review_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ReviewDatabase> reviewDataBase(Ref ref) async {
  return ReviewDatabase();
}

@Riverpod(keepAlive: true)
Future<ReviewRepository> reviewRepository(Ref ref) async {
  final db = await ref.watch(reviewDataBaseProvider.future);

  return ReviewRepositoryImpl(db);
}

@riverpod
Future<List<PubReviewWithBeers>> pubReviews(Ref ref, String pubId) async {
  final repository = await ref.watch(reviewRepositoryProvider.future);
  return repository.getReviewsForPub(pubId);
}

@riverpod
Future<Map<BeerType, int>> beerTypeCount(Ref ref) async {
  final repository = await ref.watch(reviewRepositoryProvider.future);
  return repository.getBeerTypesCount();
}
