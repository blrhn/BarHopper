import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/http_dio.dart';
import '../../domain/repositories/pub_repository.dart';
import '../repositories/pub_repository_impl.dart';

part "pub_repository_provider.g.dart";

@riverpod
PubRepository pubRepository(Ref ref) {
  final dio = ref.watch(dioProvider);

  return PubRepositoryImpl(dio);
}
