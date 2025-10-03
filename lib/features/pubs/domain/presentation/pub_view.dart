import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/ui_config.dart';
import '../../../../core/database/providers/review_provider.dart';
import '../../../../core/router/routes.dart';
import '../entities/pub.dart';
import 'review_card.dart';

class PubView extends ConsumerWidget {
  final Pub pub;

  const PubView({super.key, required this.pub});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(pubReviewsProvider(pub.id!));

    return Scaffold(
      appBar: AppBar(title: Text(pub.name!)),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {
                GoRouter.of(
                  context,
                ).push("${Routes.pubReview}/{${pub.id}}", extra: pub);
              },
              label: const Text(UIPubViewConfig.addVisitText),
              icon: const Icon(Icons.add),
            ),
            Expanded(
              child: switch (reviews) {
                AsyncData(:final value) =>
                  value.isEmpty
                      ? const Center(
                          child: Text(UIPubViewConfig.reviewsEmptyText),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            final review = value[index];
                            return ReviewCard(
                              reviewWithBeers: review,
                              pub: pub,
                            );
                          },
                          itemCount: value.length,
                        ),
                AsyncError(:final error) => Text(
                  "${UIPubViewConfig.pubsError}$error",
                ),
                _ => const Center(child: CircularProgressIndicator()),
              },
            ),
          ],
        ),
      ),
    );
  }
}
