import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/ui_config.dart';
import '../../data/providers/city_provider.dart';
import '../../data/providers/selected_city.dart';
import '../entities/city.dart';

class SearchCityBar extends ConsumerWidget {
  const SearchCityBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Autocomplete<City>(
      optionsBuilder: (textEditingValue) async {
        final query = textEditingValue.text;

        if (query.isEmpty) return const Iterable<City>.empty();

        return await ref.read(cityProvider(query).future);
      },
      displayStringForOption: (option) => option.cityDetails!,
      onSelected: (selected) =>
          ref.read(selectedCityProvider.notifier).select(selected),
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onTapOutside: (event) => focusNode.unfocus(),
          decoration: InputDecoration(
            label: const Text(UISearchConfig.labelText),
            hint: const Text(UISearchConfig.hintText),
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UISearchConfig.borderRadius),
            ),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Material(
          child: ListView.builder(
            itemBuilder: (context, index) {
              final option = options.elementAt(index);
              return ListTile(
                title: Text(option.cityDetails!),
                subtitle: Text(
                  option.postcode ?? UISearchConfig.noPostCodeText,
                ),
                onTap: () => onSelected(option),
              );
            },
            itemCount: options.length,
          ),
        );
      },
    );
  }
}
