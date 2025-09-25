import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/city.dart';

part 'selected_city.g.dart';

@riverpod
class SelectedCity extends _$SelectedCity {
  @override
  City? build() {
    return null;
  }

  void select(City city) {
    state = city;
  }
}
