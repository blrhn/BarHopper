import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/config/ui_config.dart';
import 'pub_limit_provider.dart';

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const SettingsDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final limit = ref.watch(pubLimitProvider);

    return AlertDialog(
      title: const Text(
        UISettingsPanelConfig.panelTextTitle,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(UISettingsPanelConfig.panelInfoText + limit.toString()),
            const SizedBox(height: UISettingsPanelConfig.textSliderHeight),
            Slider(
              value: limit,
              min: UISettingsPanelConfig.panelItems.first,
              max: UISettingsPanelConfig.panelItems.last,
              divisions: UISettingsPanelConfig.panelItems.length - 1,
              onChanged: (value) =>
                  ref.read(pubLimitProvider.notifier).setLimit(value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text(UISettingsPanelConfig.saveButtonText),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
