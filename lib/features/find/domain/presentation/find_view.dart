import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/ui_config.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../pubs/data/providers/pub_provider.dart';
import '../../data/providers/distance_limit.dart';
import '../../data/providers/selected_city.dart';
import '../entities/city.dart';
import 'search_city_bar.dart';

class FindView extends ConsumerWidget {
  const FindView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final distance = ref.watch(distanceLimitProvider);
    final city = ref.watch(selectedCityProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(UISearchConfig.appBarText),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(UISearchConfig.padding),
          child: Column(
            children: [
              const SearchCityBar(),
              const SizedBox(height: UISearchConfig.sizedBoxHeight),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${UISearchConfig.radiusText}$distance${UIPubCardConfig.distanceUnit}",
                  ),
                  Slider(
                    value: distance,
                    min: UISearchConfig.distances.first,
                    max: UISearchConfig.distances.last,
                    divisions: UISearchConfig.distances.length - 1,
                    onChanged: (value) => ref
                        .read(distanceLimitProvider.notifier)
                        .setLimit(value),
                  ),
                ],
              ),
              const Divider(),

              if (city == null)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(UISearchConfig.padding),
                    child: Text(UISearchConfig.cityNullText),
                  ),
                )
              else
                _PubList(city: city, distance: distance),
            ],
          ),
        ),
      ),
    );
  }
}

class _PubList extends ConsumerWidget {
  final City city;
  final double distance;

  const _PubList({required this.city, required this.distance});

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
                      onTap: () {},
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
