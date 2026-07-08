import 'package:example/catalog/example_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExampleScaffold extends StatelessWidget {
  const ExampleScaffold({
    super.key,
    required this.entry,
    required this.body,
  });

  final ExampleEntry entry;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.title),
        actions: [
          IconButton(
            tooltip: 'Copy source path',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: entry.sourceFile));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Copied: ${entry.sourceFile}')),
              );
            },
            icon: const Icon(Icons.copy_outlined),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MetaPanel(entry: entry),
          const Divider(height: 1),
          Expanded(child: body),
        ],
      ),
    );
  }
}

class _MetaPanel extends StatelessWidget {
  const _MetaPanel({required this.entry});

  final ExampleEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(entry.category.icon, size: 18, color: entry.category.color),
                const SizedBox(width: 8),
                Text(entry.category.label, style: theme.textTheme.labelLarge),
              ],
            ),
            const SizedBox(height: 8),
            SelectableText(
              entry.sourceFile,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                color: theme.colorScheme.primary,
              ),
            ),
            if (entry.description != null) ...[
              const SizedBox(height: 6),
              Text(entry.description!, style: theme.textTheme.bodySmall),
            ],
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: entry.apis
                  .map(
                    (api) => Chip(
                      label: Text(api, style: const TextStyle(fontSize: 12)),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key, required this.entry});

  final ExampleEntry entry;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      entry: entry,
      body: entry.builder(context),
    );
  }
}
