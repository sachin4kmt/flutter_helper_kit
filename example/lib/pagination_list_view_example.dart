import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';


class PaginationListViewExample extends StatefulWidget {
  const PaginationListViewExample({super.key});

  @override
  State<PaginationListViewExample> createState() => _PaginationListViewExampleState();
}

class _PaginationListViewExampleState extends State<PaginationListViewExample> {
  final List<String> items = List.generate(20, (index) => 'Item $index');

  bool isLoading = false;

  bool hasMoreData = true;

  void fetchMoreData() async {
    if (isLoading || !hasMoreData) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    final newItems = List.generate(10, (index) => 'Item ${items.length + index}');
    setState(() {
      items.addAll(newItems);
      isLoading = false;
      if (newItems.isEmpty) {
        hasMoreData = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Infinite List View')),
      body: ListViewPagination(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
        itemCount: items.length,
        nextData: fetchMoreData,
        hasNext: hasMoreData,
        loadingWidget: const Center(child: CircularProgressIndicator()),
        scrollThreshold: 300,
      ),
    );
  }
}
