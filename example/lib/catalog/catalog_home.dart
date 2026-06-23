import 'package:example/app/example_scaffold.dart';
import 'package:example/catalog/example_catalog.dart';
import 'package:example/catalog/example_entry.dart';
import 'package:flutter/material.dart';

class CatalogHome extends StatefulWidget {
  const CatalogHome({super.key});

  @override
  State<CatalogHome> createState() => _CatalogHomeState();
}

class _CatalogHomeState extends State<CatalogHome> {
  String _query = '';

  List<ExampleEntry> get _filtered {
    if (_query.trim().isEmpty) return exampleCatalog;
    final q = _query.toLowerCase();
    return exampleCatalog.where((e) {
      return e.title.toLowerCase().contains(q) ||
          e.sourceFile.toLowerCase().contains(q) ||
          e.apis.any((a) => a.toLowerCase().contains(q));
    }).toList();
  }

  Map<ExampleCategory, List<ExampleEntry>> get _grouped {
    final map = <ExampleCategory, List<ExampleEntry>>{};
    for (final entry in _filtered) {
      map.putIfAbsent(entry.category, () => []).add(entry);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _grouped;

    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_helper_kit Examples'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: SearchBar(
              hintText: 'Search by title, file or API...',
              leading: const Icon(Icons.search),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              '${_filtered.length} examples · ${ExampleCategory.values.length} categories',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          for (final category in ExampleCategory.values)
            if (grouped[category]?.isNotEmpty ?? false) ...[
              _CategoryHeader(category: category, count: grouped[category]!.length),
              ...grouped[category]!.map((entry) => _ExampleTile(entry: entry)),
            ],
        ],
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.category, required this.count});

  final ExampleCategory category;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Row(
        children: [
          Icon(category.icon, color: category.color, size: 20),
          const SizedBox(width: 8),
          Text(
            '${category.label} ($count)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _ExampleTile extends StatelessWidget {
  const _ExampleTile({required this.entry});

  final ExampleEntry entry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(entry.title),
      subtitle: Text(
        entry.sourceFile,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ExamplePage(entry: entry)),
        );
      },
    );
  }
}
