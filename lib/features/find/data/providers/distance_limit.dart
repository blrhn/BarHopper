import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/ui_config.dart';

part 'distance_limit.g.dart';

@riverpod
class DistanceLimit extends _$DistanceLimit {
  @override
  double build() => UISearchConfig.distances.first;

  void setLimit(double limit) {
    state = limit;
  }
}
