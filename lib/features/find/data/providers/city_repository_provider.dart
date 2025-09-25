import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/http_dio.dart';
import '../../domain/repositories/city_repository.dart';
import '../repositories/city_repository_impl.dart';

part 'city_repository_provider.g.dart';

@riverpod
CityRepository cityRepository(Ref ref) {
  final dio = ref.watch(dioProvider);

  return CityRepositoryImpl(dio);
}
