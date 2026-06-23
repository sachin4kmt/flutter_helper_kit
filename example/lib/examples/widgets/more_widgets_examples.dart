import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

Widget tapSafeGestureDemo(BuildContext context) {
  return Center(
    child: TapSafeGesture(
      cooldown: const Duration(seconds: 2),
      builder: (context, onTap) => ElevatedButton(
        onPressed: onTap,
        child: const Text('TapSafeGesture (2s cooldown)'),
      ),
      onTap: () async {
        await Future.delayed(const Duration(seconds: 1));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tap completed')),
          );
        }
      },
    ),
  );
}

Widget flutterListViewDemo(BuildContext context) {
  final items = List.generate(8, (i) => 'Row $i');
  return FlutterListView<String>.separator(
    items: items,
    padding: const EdgeInsets.all(16),
    scrollDirection: FlutterScrollDirection.vertical,
    separatorBuilder: (_, __) => const Divider(height: 1),
    itemBuilder: (_, item) => ListTile(title: Text(item)),
  );
}

Widget unFocusableDemo(BuildContext context) {
  return UnFocusable(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const TextField(decoration: InputDecoration(labelText: 'Tap outside to dismiss keyboard')),
          const SizedBox(height: 8),
          const Text('Wrapped with UnFocusable'),
        ],
      ),
    ),
  );
}

Widget customIndicatorDemo(BuildContext context) {
  return const _CustomIndicatorDemo();
}

class _CustomIndicatorDemo extends StatefulWidget {
  const _CustomIndicatorDemo();

  @override
  State<_CustomIndicatorDemo> createState() => _CustomIndicatorDemoState();
}

class _CustomIndicatorDemoState extends State<_CustomIndicatorDemo> {
  var _loading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIndicator(
          isActive: _loading,
          child: Container(
            width: 200,
            height: 100,
            alignment: Alignment.center,
            color: Colors.blue.shade50,
            child: const Text('Content'),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            setState(() => _loading = true);
            await Future.delayed(const Duration(seconds: 2));
            if (mounted) setState(() => _loading = false);
          },
          child: const Text('Toggle CustomIndicator'),
        ),
      ],
    );
  }
}

Widget separatedColumnDemo(BuildContext context) {
  return SeparatedColumn(
    separatorBuilder: (_, __) => const Divider(),
    children: const [
      Text('Item 1'),
      Text('Item 2'),
      Text('Item 3'),
    ],
  );
}

Widget profileShimmerDemo(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: ProfileShimmer(isDarkMode: false),
  );
}

Widget doublePressBackLiveDemo(BuildContext context) {
  return DoublePressBackWidget(
    message: 'Press back again to exit',
    onWillPop: () {},
    child: const Center(child: Text('Press system back twice to see snackbar')),
  );
}

Widget animatedListWrapperDemo(BuildContext context) {
  return AnimatedListWrapper(
    itemCount: 6,
    animationType: ListAnimationType.slideY,
    itemBuilder: (_, i) => Card(child: ListTile(title: Text('Animated item $i'))),
  );
}

Widget outlineGlowDemo(BuildContext context) {
  return Center(
    child: OutlineAvatarGlow(
      glowColor: Colors.purple,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.purple.shade100,
        child: const Icon(Icons.star, color: Colors.purple),
      ),
    ),
  );
}

Widget textAvatarDemo(BuildContext context) {
  return Center(child: TextAvatar(text: 'Flutter Helper Kit'));
}

Widget roundedCheckBoxDemo(BuildContext context) {
  return Center(
    child: RoundedCheckBox(
      isChecked: true,
      text: 'Accept terms',
      onTap: (_) {},
    ),
  );
}

Widget showDialogCloseDemo(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () => showDialogWithCloseIcon(
        context: context,
        title: const Icon(Icons.info_outline, size: 40),
        content: const Text('Dialog with animated close icon'),
      ),
      child: const Text('showDialogWithCloseIcon'),
    ),
  );
}
