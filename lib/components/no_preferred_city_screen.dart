import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/routes/add_city.dart";

class NoPreferredCityScreen extends StatelessWidget {
  final VoidCallback onCityAdded;

  const NoPreferredCityScreen({super.key, required this.onCityAdded});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final colors = theme.colorScheme;

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.priority_high_rounded, size: 56, color: colors.primary),
        const SizedBox(height: 12),
        Text(
          "Nothing to show yet,\nyou can start by adding a city!",
          style: text.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () => onAddCity(context),
          icon: const Icon(Icons.add_rounded),
          label: const Text("Add a city"),
        )
      ]),
    );
  }

  Future<void> onAddCity(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCity()));

    if (context.mounted) {
      onCityAdded.call();
    }
  }
}
