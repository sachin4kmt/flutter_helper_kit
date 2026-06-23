import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

Widget appButtonDemo(BuildContext context) {
  return Center(
    child: AppButton(onTap: () {}, text: 'AppButton'),
  );
}

Widget sliderButtonDemo(BuildContext context) {
  return Center(
    child: SliderButton(
      width: 300,
      height: 60,
      label: const Text('Slide to confirm'),
      action: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SliderButton.action() completed')),
        );
        return true;
      },
    ),
  );
}

Widget passwordStrengthDemo(BuildContext context) {
  return const _PasswordStrengthDemo();
}

class _PasswordStrengthDemo extends StatefulWidget {
  const _PasswordStrengthDemo();

  @override
  State<_PasswordStrengthDemo> createState() => _PasswordStrengthDemoState();
}

class _PasswordStrengthDemoState extends State<_PasswordStrengthDemo> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: controller,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          PasswordStrengthIndicator(textController: controller),
        ],
      ),
    );
  }
}

Widget readMoreDemo(BuildContext context) {
  const longText =
      'Flutter Helper Kit bundles extensions, widgets, and animations used across Paydrop and WhereToNow projects. '
      'This example app maps each demo to its source file so you always know which API you are looking at.';

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReadMoreText(longText, trimLines: 3),
        const Divider(height: 32),
        ReadMoreTextEnhanced(
          longText,
          trimLines: 3,
          annotations: [
            Annotation(
              regExp: RegExp(r'Paydrop|WhereToNow'),
              spanBuilder: ({required text, required textStyle}) => TextSpan(
                text: text,
                style: textStyle.copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget sharpCornersDemo(BuildContext context) {
  return Center(
    child: Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: SharpBorderRadius(cornerRadius: 24, sharpRatio: 0.6),
      ),
      alignment: Alignment.center,
      child: const Text('SharpBorderRadius', style: TextStyle(color: Colors.white)),
    ),
  );
}

Widget flutterTagDemo(BuildContext context) {
  return Center(
    child: FlutterTag(
      tagContent: const Text('NEW', style: TextStyle(color: Colors.white, fontSize: 10)),
      tagStyle: const FlutterTagStyle(tagColor: Colors.red),
      child: Container(
        width: 120,
        height: 80,
        color: Colors.grey.shade300,
        alignment: Alignment.center,
        child: const Text('Item'),
      ),
    ),
  );
}

Widget avatarGlowDemo(BuildContext context) {
  return Center(
    child: AvatarGlow(
      glowColor: Colors.blue,
      child: CircleAvatar(radius: 36, backgroundColor: Colors.blue.shade100, child: const Icon(Icons.person)),
    ),
  );
}

Widget uiComponentsDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      CenterTextDivider.text(label: 'OR', color: Colors.black87),
      const SizedBox(height: 16),
      const DashDivider(),
      const SizedBox(height: 16),
      GradientText('GradientText', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      RatingBarWidget(rating: 3.5, onRatingChanged: (_) {}),
      const SizedBox(height: 16),
      Marquee(child: Text('Marquee — scrolls long text horizontally')),
      const SizedBox(height: 16),
      DottedBorderWidget(
        child: const Padding(padding: EdgeInsets.all(16), child: Text('DottedBorderWidget')),
      ),
    ],
  );
}

Widget paginationDemo(BuildContext context) {
  return const PaginationListViewExample();
}

Widget rollingDigitDemo(BuildContext context) {
  return Center(
    child: UniversalDigitCounter(
      value: 12345,
      type: DigitAnimationType.simple,
      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    ),
  );
}

Widget ticketClippersDemo(BuildContext context) {
  return Center(
    child: TicketClipper(
      clipper: PointedEdgeClipper(),
      shadow: BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 8),
      child: Container(
        width: 280,
        height: 120,
        color: Colors.orange.shade100,
        alignment: Alignment.center,
        child: const Text('TicketClipper + PointedEdgeClipper'),
      ),
    ),
  );
}

Widget cupertinoDialogsDemo(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () => AppCupertinoActionSheet.showActionSheet<String>(
            context: context,
            title: 'Choose',
            actions: [
              ActionSheetItem(value: 'a', label: 'Option A'),
              ActionSheetItem(value: 'b', label: 'Option B', isDestructive: true),
            ],
          ),
          child: const Text('AppCupertinoActionSheet'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => AppCupertinoDialog.info(
            context: context,
            title: 'Info',
            message: 'AppCupertinoDialog.info()',
          ),
          child: const Text('AppCupertinoDialog.info'),
        ),
      ],
    ),
  );
}

Widget timerSpaceDemo(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TimerBuilder.periodic(
          const Duration(seconds: 1),
          builder: (context) => Text('TimerBuilder: ${DateTime.now().second}s'),
        ),
        16.height(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('A'), Space(8), Text('B')],
        ),
      ],
    ),
  );
}

Widget shimmerToastDemo(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const TextShimmer(text: 'Loading shimmer...'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => FlutterToast.show('FlutterToast.show()', context),
          child: const Text('Show Toast'),
        ),
      ],
    ),
  );
}

Widget customBannerDemo(BuildContext context) {
  return CustomBanner(
    message: 'NEW',
    location: CustomBannerLocation.topStart,
    child: Container(
      height: 120,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Text('CustomBanner child'),
    ),
  );
}

class PaginationListViewExample extends StatefulWidget {
  const PaginationListViewExample({super.key});

  @override
  State<PaginationListViewExample> createState() => _PaginationListViewExampleState();
}

class _PaginationListViewExampleState extends State<PaginationListViewExample> {
  final items = List.generate(15, (i) => 'Item $i');
  var isLoading = false;
  var hasMore = true;

  Future<void> fetchMore() async {
    if (isLoading || !hasMore) return;
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      items.addAll(List.generate(5, (i) => 'Item ${items.length + i}'));
      isLoading = false;
      if (items.length > 30) hasMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListViewPagination(
      itemCount: isLoading ? items.length + 1 : items.length,
      hasNext: hasMore,
      nextData: fetchMore,
      itemBuilder: (_, i) {
        if (i >= items.length) {
          return const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()));
        }
        return ListTile(title: Text(items[i]));
      },
    );
  }
}
