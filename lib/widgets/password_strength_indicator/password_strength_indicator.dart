
import 'package:flutter/material.dart';

import 'password_rules_enum.dart';
import 'password_strength_enum.dart';

class _PasswordRuleConfig {
  final String Function() text;
  final bool Function() isValid;

  _PasswordRuleConfig({required this.text, required this.isValid});
}

class PasswordStrengthIndicator extends StatefulWidget {
  final TextEditingController textController;
  final int? maxLength;
  final int minLength;
  final IconData? successIcon;
  final IconData? unSuccessIcon;
  final Widget? successWidget;
  final Widget? unSuccessWidget;
  final double textSize;
  final bool hideRules;

  // NEW: rule flags
  final List<PasswordRule> rules;

  const PasswordStrengthIndicator({
    super.key,
    required this.textController,
    this.maxLength,
    this.minLength = 8,
    this.successIcon,
    this.unSuccessIcon,
    this.successWidget,
    this.unSuccessWidget,
    this.textSize = 14,
    this.hideRules = false,
    this.rules = const [PasswordRule.length, PasswordRule.capital, PasswordRule.lowercase, PasswordRule.number, PasswordRule.symbol],
  });

  @override
  State<PasswordStrengthIndicator> createState() => PasswordStrengthIndicatorState();
}

class PasswordStrengthIndicatorState extends State<PasswordStrengthIndicator> {
  //ignore: prefer_single_quotes
  RegExp numReg = RegExp(r".*[0-9].*");

  //ignore: prefer_single_quotes
  RegExp simpleReg = RegExp(r".*[a-z].*");

  //ignore: prefer_single_quotes
  RegExp capitalReg = RegExp(r".*[A-Z].*");
  RegExp symbolsReg = RegExp(r'.*[!@#\$&*~].*');
  double get progress => passedCount / widget.rules.length;


  @override
  void initState() {
    super.initState();
    widget.textController.addListener(() {
      setState(() {});
    });
  }

  Map<PasswordRule, _PasswordRuleConfig> get _ruleConfig => {
    PasswordRule.length: _PasswordRuleConfig(
      text: () => widget.maxLength != null
          ? 'Contain between ${widget.minLength}-${widget.maxLength} Characters'
          : 'Contain at least ${widget.minLength} Characters',
      isValid: checkLength,
    ),
    PasswordRule.capital: _PasswordRuleConfig(
      text: () => 'At least one CAPITAL letter',
      isValid: () => capitalReg.hasMatch(widget.textController.text),
    ),
    PasswordRule.lowercase: _PasswordRuleConfig(
      text: () => 'At least one simple letter',
      isValid: () => simpleReg.hasMatch(widget.textController.text),
    ),
    PasswordRule.number: _PasswordRuleConfig(text: () => 'At least one number', isValid: () => numReg.hasMatch(widget.textController.text)),
    PasswordRule.symbol: _PasswordRuleConfig(
      text: () => 'At least one special character',
      isValid: () => symbolsReg.hasMatch(widget.textController.text),
    ),
  };

/*  void calculateStrength() {
    double total = 0;
    final activeRules = widget.rules.length;

    for (var rule in widget.rules) {
      switch (rule) {
        case PasswordRule.length:
          if (checkLength()) total += 1 / activeRules;
          break;
        case PasswordRule.capital:
          if (capitalReg.hasMatch(widget.textController.text)) total += 1 / activeRules;
          break;
        case PasswordRule.lowercase:
          if (simpleReg.hasMatch(widget.textController.text)) total += 1 / activeRules;
          break;
        case PasswordRule.number:
          if (numReg.hasMatch(widget.textController.text)) total += 1 / activeRules;
          break;
        case PasswordRule.symbol:
          if (symbolsReg.hasMatch(widget.textController.text)) total += 1 / activeRules;
          break;
      }
    }

  }*/
  PasswordStrength get strength {
    if (passedCount == 0) return PasswordStrength.none;
    if (passedCount == 1) return PasswordStrength.weak;
    if (passedCount == 2) return PasswordStrength.fair;
    if (passedCount == 3) return PasswordStrength.good;
    if (passedCount == widget.rules.length - 1) return PasswordStrength.strong;
    return PasswordStrength.veryStrong;
  }

  Color get allBoxColor {
    final totalRules = widget.rules.length;

    if (passedCount == 0) return Colors.grey.shade300;

    // Special handling
    if (totalRules == 1) return Colors.green;
    if (totalRules == 2) {
      return passedCount == 1 ? Colors.red : Colors.green;
    }

    // General cases (3–5 rules)
    switch (passedCount) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.blue;
      default:
        return Colors.green;
    }
  }
  Color _boxColor(int index) {
    if (index < passedCount) {
      return allBoxColor;
    }
    return Colors.grey.shade300; // inactive boxes
  }
  int get passedCount => widget.rules.where((rule) {
    switch (rule) {
      case PasswordRule.length:
        return checkLength();
      case PasswordRule.capital:
        return capitalReg.hasMatch(widget.textController.text);
      case PasswordRule.lowercase:
        return simpleReg.hasMatch(widget.textController.text);
      case PasswordRule.number:
        return numReg.hasMatch(widget.textController.text);
      case PasswordRule.symbol:
        return symbolsReg.hasMatch(widget.textController.text);
    }
  }).length;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.85,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.005),
          // REPLACE LinearProgressIndicator WITH THIS
        Row(
          children: List.generate(widget.rules.length, (index) {
            return Expanded(
              child: Container(
                height: 5,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: _boxColor(index),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            );
          }),
        ),
          SizedBox(height: size.height * 0.015),

       /*   LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            color: strength.color,
            minHeight: 5,
          ),*/
          if (!widget.hideRules)
            Column(
              children: [
                SizedBox(height: size.height * 0.015),
                ...widget.rules.map((rule) {
                  final config = _ruleConfig[rule]!;

                  return Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.005),
                    child: conditionText(config.isValid(), config.text()),
                  );
                }),
              ],
            ),
        ],
      ),
    );
  }

  Widget conditionText(bool condition, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: condition
              ? widget.successWidget ?? Icon(widget.successIcon ?? Icons.check, color: Colors.green, size: 14)
              : widget.unSuccessWidget ?? Icon(widget.unSuccessIcon ?? Icons.clear, color: Colors.red, size: 14),
        ),
        const SizedBox(width: 12),
        SizedBox(
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14, color: condition ? Colors.green : Colors.red, height: 1.5),
          ),
        ),
      ],
    );
  }

  bool checkLength() {
    if (widget.maxLength != null) {
      return widget.textController.text.length >= widget.minLength && widget.textController.text.length <= widget.maxLength!;
    } else {
      return widget.textController.text.length >= widget.minLength;
    }
  }
}
