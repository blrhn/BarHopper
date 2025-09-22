import 'package:bar_hop/core/config/ui_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pub_limit_provider.g.dart';

@riverpod
class PubLimit extends _$PubLimit {
  @override
  double build() => UISettingsPanelConfig.panelItems.first;

  void setLimit(double limit) {
    state = limit;
  }
}
