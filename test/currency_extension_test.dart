import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/extensions/number/currency_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toCurrency indian', () {
    test('formats lakhs and crores', () {
      expect(100000.toCurrency(smartDecimal: false), '₹1,00,000.00');
      expect(1000000.toCurrency(smartDecimal: false), '₹10,00,000.00');
      expect(10000000.toCurrency(smartDecimal: false), '₹1,00,00,000.00');
      expect(
        1234567.89.toCurrency(smartDecimal: false),
        '₹12,34,567.89',
      );
    });

    test('smart decimal trims trailing zeros', () {
      expect(1000.toCurrency(), '₹1,000');
      expect(1000.5.toCurrency(), '₹1,000.5');
    });
  });

  group('toCurrency international', () {
    test('groups by thousands', () {
      expect(
        1000000.toCurrency(
          style: CurrencyStyle.international,
          symbol: r'$',
          smartDecimal: false,
        ),
        r'$1,000,000.00',
      );
      expect(
        1234567.89.toCurrency(
          style: CurrencyStyle.international,
          symbol: r'$',
          smartDecimal: false,
        ),
        r'$1,234,567.89',
      );
    });

    test('trailing symbol', () {
      expect(
        99.toCurrency(
          style: CurrencyStyle.international,
          symbol: '€',
          symbolPosition: CurrencySymbolPosition.trailing,
          smartDecimal: false,
        ),
        '99.00€',
      );
    });
  });

  group('nullable', () {
    test('null without nullValue formats zero', () {
      const num? empty = null;
      expect(empty.toCurrency(smartDecimal: false), '₹0.00');
    });

    test('null with nullValue returns that string', () {
      const num? empty = null;
      expect(
        empty.toCurrency(
          style: CurrencyStyle.international,
          symbol: r'$',
          symbolPosition: CurrencySymbolPosition.trailing,
          nullValue: 'N/A',
        ),
        'N/A',
      );
    });
  });

  group('toCurrencyText styles', () {
    List<TextSpan> spansOf(WidgetTester tester) {
      final text = tester.widget<Text>(find.byKey(const Key('currency')));
      final root = text.textSpan! as TextSpan;
      return root.children!.cast<TextSpan>().toList();
    }

    testWidgets('only textStyle applies to both spans', (tester) async {
      const amountStyle = TextStyle(fontSize: 20, color: Colors.black);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: 1000.toCurrencyText(
              key: const Key('currency'),
              textStyle: amountStyle,
            ),
          ),
        ),
      );

      final children = spansOf(tester);
      expect(children, hasLength(2));
      expect(children[0].text, '₹');
      expect(children[0].style, amountStyle);
      expect(children[1].text, '1,000');
      expect(children[1].style, amountStyle);
    });

    testWidgets('only symbolTextStyle applies to both spans', (tester) async {
      const symbolStyle = TextStyle(fontSize: 12, color: Colors.grey);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: 1000.toCurrencyText(
              key: const Key('currency'),
              symbolTextStyle: symbolStyle,
            ),
          ),
        ),
      );

      final children = spansOf(tester);
      expect(children[0].style, symbolStyle);
      expect(children[1].style, symbolStyle);
    });

    testWidgets('both styles apply separately', (tester) async {
      const amountStyle = TextStyle(fontSize: 20, color: Colors.black);
      const symbolStyle = TextStyle(fontSize: 12, color: Colors.grey);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: 1000.toCurrencyText(
              key: const Key('currency'),
              textStyle: amountStyle,
              symbolTextStyle: symbolStyle,
            ),
          ),
        ),
      );

      final children = spansOf(tester);
      expect(children[0].text, '₹');
      expect(children[0].style, symbolStyle);
      expect(children[1].text, '1,000');
      expect(children[1].style, amountStyle);
    });
  });
}
