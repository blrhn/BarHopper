import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/ui_config.dart';
import '../../data/providers/distance_limit.dart';
import '../../data/providers/selected_city.dart';
import 'pub_list.dart';
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
                PubList(city: city, distance: distance),
            ],
          ),
        ),
      ),
    );
  }
}
