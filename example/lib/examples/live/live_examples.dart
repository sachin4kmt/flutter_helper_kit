import 'package:example/home.dart';
import 'package:example/pagination_list_view_example.dart';
import 'package:example/widgets_example/my_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

/// Live-only sandbox demos preserved from the original example app.
Widget liveHomeSandboxDemo(BuildContext context) => const HomeScreen();

Widget liveCustomTextFieldDemo(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        MyCustomTextField(
          hintText: 'MyCustomTextField — live sandbox',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: const Icon(Icons.edit_outlined),
          onFieldSubmitted: (_) {},
        ),
        const SizedBox(height: 16),
        Text(
          'Source: example/lib/widgets_example/my_custom_text_field.dart',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget livePaginationStandaloneDemo(BuildContext context) {
  return const Column(
    children: [
      Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          'Standalone pagination demo (example/lib/pagination_list_view_example.dart)',
          textAlign: TextAlign.center,
        ),
      ),
      Expanded(child: PaginationListViewExample()),
    ],
  );
}

Widget genericPickerDemo(BuildContext context) {
  final items = [
    MyDropdownItem(label: 'Flutter', value: 'flutter'),
    MyDropdownItem(label: 'Dart', value: 'dart'),
    MyDropdownItem(label: 'Material', value: 'material'),
  ];

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            final picked =
                await GenericPickerSheet.singleSelection<MyDropdownItem>(
              context: context,
              items: items,
              initialSelected: items.first,
            );
            if (context.mounted && picked != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected: ${picked.getLabel()}')),
              );
            }
          },
          child: const Text('GenericPickerSheet.singleSelection'),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () async {
            final picked =
                await GenericPickerSheet.multiSelection<MyDropdownItem>(
              context: context,
              items: items,
              initialSelected: [items.first],
            );
            if (context.mounted && picked != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Selected: ${picked.map((e) => e.getLabel()).join(', ')}')),
              );
            }
          },
          child: const Text('GenericPickerSheet.multiSelection'),
        ),
      ],
    ),
  );
}
