import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

Widget widgetAnimationsDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _AnimatedCard(
        label: 'animateWidgetElasticEntry()',
        child: const Text('Elastic Entry').animateWidgetElasticEntry(),
      ),
      _AnimatedCard(
        label: 'animateWidgetGlassReveal()',
        child: const Text('Glass Reveal').animateWidgetGlassReveal(),
      ),
      _AnimatedCard(
        label: 'animateWidgetZoomFocus()',
        child: const Text('Zoom Focus').animateWidgetZoomFocus(),
      ),
    ],
  );
}

Widget listAnimationsDemo(BuildContext context) {
  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: 5,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Card(
          child: ListTile(title: Text('Item ${index + 1}')),
        ).animateListEntry(index: index),
      );
    },
  );
}

Widget gestureAnimationDemo(BuildContext context) {
  return Center(
    child: AnimatedGestureDetector(
      effectPreset: TapEffect.bounce,
      onTap: () {},
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(16)),
        alignment: Alignment.center,
        child: const Text('Tap me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
}

Widget bottomSheetAnimationDemo(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => Container(
            height: 180,
            alignment: Alignment.center,
            child: const Text('Bottom sheet content'),
          ).animateSheetReveal(),
        );
      },
      child: const Text('Show animated sheet'),
    ),
  );
}

class _AnimatedCard extends StatelessWidget {
  const _AnimatedCard({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
