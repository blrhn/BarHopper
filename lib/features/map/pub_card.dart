import 'package:bar_hop/core/config/ui_config.dart';
import 'package:bar_hop/core/theme/app_theme.dart';
import 'package:bar_hop/features/pubs/domain/entities/pub.dart';
import 'package:flutter/material.dart';

import 'info_row.dart';

class PubCard extends StatelessWidget {
  final Pub pub;

  const PubCard({super.key, required this.pub});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: context.colorScheme.secondaryContainer,
        margin: EdgeInsets.symmetric(
          horizontal: UIPubCardConfig.symmetricEdges,
        ),
        child: SizedBox(
          width: double.infinity,
          height:
              MediaQuery.sizeOf(context).height *
              UIPubCardConfig.heightPercentage,
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                  height: UIPubCardConfig.beerIconHeight,
                  width: UIPubCardConfig.beerIconWidth,
                  child: Icon(Icons.liquor, size: UIPubCardConfig.beerIconSize),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      InfoRow(
                        text: pub.name,
                        icon: Icons.store,
                        textValueNull: UIPubCardConfig.addressLine1Null,
                        bold: true,
                      ),
                      const SizedBox(
                        height: UIPubCardConfig.infoIconTextSpaceHeight,
                      ),
                      InfoRow(
                        text: pub.address,
                        icon: Icons.location_on,
                        textValueNull: UIPubCardConfig.addressLine2Null,
                      ),
                      const SizedBox(
                        height: UIPubCardConfig.infoIconTextSpaceHeight,
                      ),
                      InfoRow(
                        text: pub.distance != null
                            ? '${pub.distance!.toStringAsFixed(UIPubCardConfig.distanceRoundPlaces)}${UIPubCardConfig.distanceUnit}'
                            : null,
                        icon: Icons.directions,
                        textValueNull: UIPubCardConfig.distanceNull,
                      ),
                      const SizedBox(
                        height: UIPubCardConfig.infoIconTextSpaceHeight,
                      ),
                      InfoRow(
                        text: pub.phoneNumber,
                        icon: Icons.phone,
                        textValueNull: UIPubCardConfig.phoneNumberNull,
                      ),
                      const SizedBox(
                        height: UIPubCardConfig.infoIconTextSpaceHeight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
