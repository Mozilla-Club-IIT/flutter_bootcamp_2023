import 'package:flutter/material.dart';

class Metric extends StatelessWidget {
  final Icon icon;
  final String value;

  const Metric({super.key, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;

    final iconTheme = theme.iconTheme.copyWith(size: 24, color: colors.onSurfaceVariant);

    return Column(mainAxisSize: MainAxisSize.min, children: [
      IconTheme(data: iconTheme, child: icon),
      const SizedBox(height: 2),
      Text(value, style: text.labelLarge?.copyWith(color: colors.onSurface)),
    ]);
  }
}
