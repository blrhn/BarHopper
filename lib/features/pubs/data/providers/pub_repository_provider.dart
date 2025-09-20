import 'package:bar_hop/core/providers/http_dio.dart';
import 'package:bar_hop/features/pubs/data/repositories/pub_repository_impl.dart';
import 'package:bar_hop/features/pubs/domain/repositories/pub_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "pub_repository_provider.g.dart";

@riverpod
PubRepository pubRepository(Ref ref) {
  final dio = ref.watch(dioProvider);

  return PubRepositoryImpl(dio);
}
