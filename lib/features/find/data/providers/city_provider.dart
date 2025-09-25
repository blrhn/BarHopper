import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/city.dart';
import 'city_repository_provider.dart';

part 'city_provider.g.dart';

@riverpod
Future<List<City>> city(Ref ref, String cityName) async {
  final repository = ref.read(cityRepositoryProvider);

  return repository.getCities(cityName);
}
