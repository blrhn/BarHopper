import 'package:flutter/material.dart';

import '../../core/config/ui_config.dart';

class InfoRow extends StatelessWidget {
  final String? text;
  final String textValueNull;
  final IconData icon;
  final bool bold;

  const InfoRow({
    super.key,
    required this.icon,
    required this.textValueNull,
    required this.text,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: UIPubCardConfig.infoIconSize),
        const SizedBox(width: UIPubCardConfig.infoIconTextSpaceWidth),
        Expanded(
          child: Text(
            text ?? textValueNull,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
