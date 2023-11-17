import "package:flutter/material.dart";

class ErrorScreen extends StatelessWidget {
  final Object error;

  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;

    late final String message;
    if (error is StateError) {
      message = (error as StateError).message;
    } else {
      message = error.toString();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Error", style: text.displaySmall?.copyWith(color: colors.error)),
        Text(
          message,
          style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
