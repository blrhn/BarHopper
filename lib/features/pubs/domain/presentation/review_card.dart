import 'package:bar_hop/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/ui_config.dart';
import '../../../../core/database/pub_review_with_beers.dart';
import '../../../../core/router/routes.dart';
import '../entities/pub.dart';

class ReviewCard extends StatelessWidget {
  final PubReviewWithBeers reviewWithBeers;
  final Pub pub;

  const ReviewCard({
    super.key,
    required this.reviewWithBeers,
    required this.pub,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(
        horizontal: UIPubReviewCardConfig.cardMarginHorizontal,
        vertical: UIPubReviewCardConfig.cardMarginVertical,
      ),
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(UIPubReviewCardConfig.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat.yMMMd().format(reviewWithBeers.review.visitDate),
                  ),
                  const Spacer(),
                  Text(reviewWithBeers.review.rating.toString()),
                  const SizedBox(width: UIPubReviewCardConfig.ratingStarSpace),
                  const Icon(
                    Icons.star,
                    size: UIPubReviewCardConfig.starIconSize,
                  ),
                ],
              ),

              const Divider(),
              Column(
                children: reviewWithBeers.beers
                    .map(
                      (beer) => ListTile(
                        visualDensity: VisualDensity.compact,
                        dense: true,
                        title: Text(beer.beerType.label),
                        subtitle: beer.notes != null && beer.notes!.isNotEmpty
                            ? Text(
                                "${UIPubReviewCardConfig.notesText}${beer.notes}",
                              )
                            : null,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        onTap: () {
          GoRouter.of(context).push(
            "${Routes.pubReview}/${reviewWithBeers.review.pubId}",
            extra: {"pub": pub, "review": reviewWithBeers},
          );
        },
      ),
    );
  }
}
