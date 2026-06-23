import 'package:flutter/material.dart';

enum ExampleCategory {
  extensions('Extensions', Icons.extension, Colors.indigo),
  widgets('Widgets', Icons.widgets, Colors.teal),
  animation('Animation', Icons.animation, Colors.deepOrange),
  appResponsive('App Responsive', Icons.phone_android, Colors.blue),
  utils('Utils', Icons.build, Colors.brown),
  reactive('Reactive', Icons.sync, Colors.purple),
  formatters('Formatters', Icons.text_fields, Colors.cyan),
  customPainter('Custom Painter', Icons.brush, Colors.pink);

  const ExampleCategory(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}

/// Describes one runnable demo mapped to package source.
class ExampleEntry {
  const ExampleEntry({
    required this.id,
    required this.category,
    required this.title,
    required this.sourceFile,
    required this.apis,
    required this.builder,
    this.description,
  });

  final String id;
  final ExampleCategory category;
  final String title;
  final String sourceFile;
  final List<String> apis;
  final WidgetBuilder builder;
  final String? description;
}
