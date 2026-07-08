import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

Widget decorationsDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Text('primaryTextStyle()', style: primaryTextStyle(size: 18, weight: FontWeight.bold)),
      const SizedBox(height: 12),
      TextField(decoration: defaultInputDecoration(hint: 'defaultInputDecoration', label: 'Name')),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: boxDecorationRoundedWithShadow(12),
        child: const Text('boxDecorationRoundedWithShadow'),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: boxDecorationWithShadow(),
        child: const Text('boxDecorationWithShadow'),
      ),
    ],
  );
}

Widget systemChromeDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Btn('setDarkStatusBar()', () => setDarkStatusBar()),
      _Btn('setLightStatusBar()', () => setLightStatusBar()),
      _Btn('setStatusBarColor(teal)', () => setStatusBarColor(Colors.teal)),
      _Btn('hideStatusBar()', () => hideStatusBar()),
      _Btn('showStatusBar()', () => showStatusBar()),
      _Btn('setOrientationPortrait()', () => setOrientationPortrait()),
    ],
  );
}

Widget passwordValidatorDemo(BuildContext context) {
  return const _PasswordValidatorDemo();
}

class _PasswordValidatorDemo extends StatefulWidget {
  const _PasswordValidatorDemo();

  @override
  State<_PasswordValidatorDemo> createState() => _PasswordValidatorDemoState();
}

class _PasswordValidatorDemoState extends State<_PasswordValidatorDemo> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pwd = controller.text;
    final rules = [
      ('Min 8 chars', Validator.hasMinimumLength(pwd, 8)),
      ('Uppercase', Validator.hasMinimumUppercase(pwd, 1)),
      ('Lowercase', Validator.hasMinimumLowercase(pwd, 1)),
      ('Number', Validator.hasMinimumNumericCharacters(pwd, 1)),
      ('Special', Validator.hasMinimumSpecialCharacters(pwd, 1)),
    ];
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
          ...rules.map(
            (r) => ListTile(
              dense: true,
              leading: Icon(r.$2 ? Icons.check_circle : Icons.circle_outlined, color: r.$2 ? Colors.green : null),
              title: Text(r.$1),
            ),
          ),
        ],
      ),
    );
  }
}

Widget numeralUtilsDemo(BuildContext context) {
  const value = 1234567;
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Tile('Numeral.indian', Numeral(value).indian),
      _Tile('Numeral.international', Numeral(value).international),
      _Tile('Numeral(3.5M).international', Numeral(3500000, digitAfterDecimal: 1).international),
    ],
  );
}

Widget commonFunctionsDemo(BuildContext context) {
  return const _CommonFunctionsBody();
}

class _CommonFunctionsBody extends StatefulWidget {
  const _CommonFunctionsBody();

  @override
  State<_CommonFunctionsBody> createState() => _CommonFunctionsBodyState();
}

class _CommonFunctionsBodyState extends State<_CommonFunctionsBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _Tile('hasMatch(email)', '${hasMatch('test@mail.com', RegExpPatterns.email)}'),
        _Tile('randomString()', randomString(length: 12)),
        ElevatedButton(
          onPressed: () => setState(() {}),
          child: const Text('Regenerate randomString'),
        ),
      ],
    );
  }
}

Widget patternUtilsDemo(BuildContext context) {
  const samples = {
    'url': 'https://flutter.dev',
    'phone': '9799408400',
    'email': 'user@example.com',
    'image': 'photo.jpg',
    'video': 'clip.mp4',
  };
  final patterns = {
    'url': RegExpPatterns.url,
    'phone': RegExpPatterns.phone,
    'email': RegExpPatterns.email,
    'image': RegExpPatterns.image,
    'video': RegExpPatterns.video,
  };
  return ListView(
    padding: const EdgeInsets.all(16),
    children: patterns.entries
        .map(
          (e) => _Tile(
            'RegExpPatterns.${e.key}',
            '${hasMatch(samples[e.key], e.value)} → ${samples[e.key]}',
          ),
        )
        .toList(),
  );
}

Widget flutterHelperUtilsDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Tile('degreeToRadian(180)', '${degreeToRadian(180)}'),
      ElevatedButton(
        onPressed: () async {
          final start = DateTime.now();
          await wait(1000);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('wait(1000) ≈ ${DateTime.now().difference(start).inMilliseconds}ms')),
            );
          }
        },
        child: const Text('wait(1000) — pause 1 second'),
      ),
    ],
  );
}

Widget printfConsoleDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Text(
        'Tap buttons — output appears in the debug console (IDE / flutter run).',
        style: TextStyle(fontSize: 13),
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ElevatedButton(
            onPressed: () => printfSuccess({'status': 'ok', 'id': 42}, tag: 'DEMO'),
            child: const Text('printfSuccess'),
          ),
          ElevatedButton(
            onPressed: () => printfWarn('Cache miss', tag: 'DEMO'),
            child: const Text('printfWarn'),
          ),
          ElevatedButton(
            onPressed: () => printfError('Something failed', tag: 'DEMO'),
            child: const Text('printfError'),
          ),
          ElevatedButton(
            onPressed: () => printfTable(
              {'host': 'api.example.com', 'token': '***', 'retry': 2},
              title: 'CONFIG',
              tag: 'DEMO',
            ),
            child: const Text('printfTable'),
          ),
          ElevatedButton(
            onPressed: () {
              printHttpRequest(
                method: 'POST',
                url: 'https://api.example.com/login',
                headers: {'Content-Type': 'application/json'},
                body: {'email': 'user@test.com'},
              );
              printHttpResponse(
                method: 'POST',
                url: 'https://api.example.com/login',
                statusCode: 200,
                body: {'token': 'abc'},
                duration: const Duration(milliseconds: 240),
              );
            },
            child: const Text('HTTP logs'),
          ),
        ],
      ),
      const SizedBox(height: 16),
      SelectableText(
        printfSeparator(object: 'ANSI STYLES', length: 10),
        style: const TextStyle(fontFamily: 'monospace'),
      ),
    ],
  );
}

class _Tile extends StatelessWidget {
  const _Tile(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
        subtitle: Text(value),
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  const _Btn(this.label, this.onPressed);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(onPressed: onPressed, child: Text(label)),
    );
  }
}
