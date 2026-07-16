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

Widget textIconDemo(BuildContext context) {
  return Center(
    child: TextIcon(
      text: 'TextIcon with prefix',
      prefix: const Icon(Icons.star, color: Colors.amber),
      suffix: const Icon(Icons.chevron_right),
      boxDecoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      edgeInsets: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
  );
}

Widget widgetHelperDemo(BuildContext context) {
  final items = ['Apple', 'Banana', 'Cherry'];
  return ListView(
    padding: const EdgeInsets.all(16),
    children: WidgetHelper.widgetMap(
      items,
      (item) => [
        ListTile(title: Text(item)),
        const Divider(height: 1),
      ],
    ),
  );
}

Widget sliverSpaceDemo(BuildContext context) {
  return CustomScrollView(
    slivers: [
      const SliverToBoxAdapter(child: ListTile(title: Text('Above SliverSpace'))),
      const SliverSpace(24, color: Color(0xFFE3F2FD)),
      const SliverToBoxAdapter(child: ListTile(title: Text('Below SliverSpace'))),
      SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            const Text('SpaceMax + Space.expand in Row:'),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Left'),
                16.spaceMax(),
                Container(color: Colors.teal.shade100, child: const Text(' expand ')),
              ],
            ),
            const SizedBox(height: 16),
            const Text('SpaceMin(min: 10) between widgets:'),
            const SizedBox(height: 8),
            const SizedBox(
              height: 80,
              child: Column(
                children: [
                  Text('Top'),
                  SpaceMin(min: 10),
                  Text('Bottom'),
                ],
              ),
            ),
          ]),
        ),
      ),
    ],
  );
}

Widget avatarGlowMultiColorDemo(BuildContext context) {
  return Center(
    child: AvatarGlowMultiColor(
      glowColors: const [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue],
      child: CircleAvatar(
        radius: 36,
        backgroundColor: Colors.white,
        child: Icon(Icons.palette, color: Colors.purple.shade400),
      ),
    ),
  );
}

Widget outlineGlowMultiColorDemo(BuildContext context) {
  return Center(
    child: OutlineAvatarGlowMultiColor(
      glowColors: const [Colors.pink, Colors.purple, Colors.indigo],
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.purple.shade50,
        child: const Icon(Icons.auto_awesome, color: Colors.purple),
      ),
    ),
  );
}

Widget sharpCornersFullDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      SharpClipRect(
        radius: const SharpBorderRadius.all(SharpRadius(cornerRadius: 20, sharpRatio: 0.5)),
        child: Container(
          height: 80,
          color: Colors.deepPurple,
          alignment: Alignment.center,
          child: const Text('SharpClipRect', style: TextStyle(color: Colors.white)),
        ),
      ),
      const SizedBox(height: 16),
      SharpClipCircle(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.teal.shade100,
            border: Border.all(color: Colors.teal, width: 3),
          ),
        ),
      ),
      const SizedBox(height: 8),
      const Center(child: Text('SharpClipCircle')),
    ],
  );
}

Widget shimmerVariantsDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: const [
      Text('ProfilePageShimmer', style: TextStyle(fontWeight: FontWeight.bold)),
      ProfilePageShimmer(isDarkMode: false),
      SizedBox(height: 16),
      Text('ListTileShimmer'),
      ListTileShimmer(isDarkMode: false),
      SizedBox(height: 16),
      Text('VideoShimmer'),
      VideoShimmer(isDarkMode: false),
      SizedBox(height: 16),
      Text('YoutubeShimmer'),
      YoutubeShimmer(isDarkMode: false),
      SizedBox(height: 16),
      Text('PlayStoreShimmer'),
      PlayStoreShimmer(isDarkMode: false),
    ],
  );
}

Widget ticketClippersFullDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      TicketClipper(
        clipper: RoundedEdgeClipper(edge: Edge.bottom, points: 12),
        child: Container(
          height: 100,
          color: Colors.blue.shade100,
          alignment: Alignment.center,
          child: const Text('RoundedEdgeClipper'),
        ),
      ),
      const SizedBox(height: 16),
      TicketClipper(
        clipper: TicketRoundedEdgeClipper(),
        shadow: BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 6),
        child: Container(
          height: 100,
          color: Colors.green.shade100,
          alignment: Alignment.center,
          child: const Text('TicketRoundedEdgeClipper'),
        ),
      ),
    ],
  );
}

Widget digitAnimationTypesDemo(BuildContext context) {
  return const _DigitTypesDemo();
}

class _DigitTypesDemo extends StatefulWidget {
  const _DigitTypesDemo();

  @override
  State<_DigitTypesDemo> createState() => _DigitTypesDemoState();
}

class _DigitTypesDemoState extends State<_DigitTypesDemo> {
  var _value = 1234;
  var _type = DigitAnimationType.flip;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UniversalDigitCounter(
          value: _value,
          type: _type,
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => setState(() => _value += 111),
              child: const Text('+111'),
            ),
            DropdownButton<DigitAnimationType>(
              value: _type,
              onChanged: (v) => setState(() => _type = v!),
              items: DigitAnimationType.values
                  .map((t) => DropdownMenuItem(value: t, child: Text(t.name)))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}

Widget readMoreTextBasicDemo(BuildContext context) {
  const text =
      'ReadMoreText (basic) truncates long copy. Flutter Helper Kit includes both '
      'ReadMoreText and ReadMoreTextEnhanced with annotations support.';
  return Padding(
    padding: const EdgeInsets.all(16),
    child: ReadMoreText(text, trimLines: 2),
  );
}
