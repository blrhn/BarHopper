import 'package:bar_hop/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/ui_config.dart';
import '../../../../core/router/routes.dart';
import '../../../pubs/data/providers/pub_provider.dart';
import '../entities/city.dart';

class PubList extends ConsumerWidget {
  final City city;
  final double distance;

  const PubList({super.key, required this.city, required this.distance});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pubs = ref.watch(
      nearestPubsWithRadiusProvider(city.coords!, distance.toInt()),
    );

    return switch (pubs) {
      AsyncData(:final value) =>
        value.isEmpty
            ? const Center(child: Text(UISearchConfig.nullPubs))
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final pub = value[index];
                  return Card(
                    color: context.colorScheme.secondaryContainer,
                    child: ListTile(
                      title: Text(pub.name!),
                      subtitle: Text(pub.address!),
                      trailing: Text(
                        pub.distance!.toStringAsFixed(
                              UIPubCardConfig.distanceRoundPlaces,
                            ) +
                            UIPubCardConfig.distanceUnit,
                      ),
                      onTap: () {
                        GoRouter.of(
                          context,
                        ).push("${Routes.pub}/${pub.id}", extra: pub);
                      },
                      splashColor: Colors.transparent,
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: UISearchConfig.sizedBoxHeight),
                itemCount: value.length,
              ),
      AsyncError(:final error) => Text("${UISearchConfig.pubsError}$error"),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
