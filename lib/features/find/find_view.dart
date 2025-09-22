import 'package:bar_hop/core/config/ui_config.dart';
import 'package:bar_hop/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FindView extends StatelessWidget {
  const FindView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController cityController = TextEditingController(
      text: "Piła",
    );

    final List<Map<String, String>> places = List.generate(
      10,
      (index) => {
        "name": "${index + 1}",
        "location": "location",
        "distance": "${(index + 1)} km",
      },
    );

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
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  label: const Text(UISearchConfig.labelText),
                  hint: const Text(UISearchConfig.hintText),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      UISearchConfig.borderRadius,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: UISearchConfig.sizedBoxHeight),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${UISearchConfig.radiusText}25 km"),
                  Slider(
                    value: UISearchConfig.distances.first,
                    min: UISearchConfig.distances.first,
                    max: UISearchConfig.distances.last,
                    divisions: UISearchConfig.distances.length - 1,
                    onChanged: null,
                  ),
                ],
              ),
              const Divider(),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final place = places[index];
                  return Card(
                    color: context.colorScheme.secondaryContainer,
                    child: ListTile(
                      title: Text(place["location"]!),
                      trailing: Text(place["distance"]!),
                      onTap: () {},
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: UISearchConfig.sizedBoxHeight),
                itemCount: places.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
