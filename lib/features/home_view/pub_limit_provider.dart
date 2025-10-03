import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/config/ui_config.dart';

part 'pub_limit_provider.g.dart';

@riverpod
class PubLimit extends _$PubLimit {
  static const _key = "pub_limit";

  @override
  double build() {
    _readLimit();
    return UISettingsPanelConfig.panelItems.first;
  }

  Future<void> _readLimit() async {
    final prefs = await SharedPreferences.getInstance();
    final limit = prefs.getDouble(_key);

    if (limit != null) {
      state = limit;
    }
  }

  Future<void> setLimit(double limit) async {
    state = limit;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_key, limit);
  }
}
