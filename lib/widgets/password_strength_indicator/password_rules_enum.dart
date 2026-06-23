

enum PasswordRule {
  length,
  capital,
  lowercase,
  number,
  symbol;
}


/*extension PasswordRuleColor on PasswordRule {
  Color get color {
    switch (this) {
      case PasswordRule.length:
        return Colors.grey;
      case PasswordRule.capital:
        return Colors.green;
      case PasswordRule.lowercase:
        return Colors.teal;
      case PasswordRule.number:
        return Colors.orange;
      case PasswordRule.symbol:
        return Colors.purple;
    }
  }
}*/

