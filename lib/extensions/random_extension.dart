part of flutter_helper_kit;

extension RandomExtension on math.Random{
  String  generateLoremIpsumWords([int? limit]) {
    const String paragraph = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
    final List<String> words = paragraph.split(' ');
    String result = '';
    for (int i = 0; i < (limit ?? words.length); i++) {
      result += '${words[i % words.length]} ';
    }
    return result.trim();
  }

  ///default 365*5 =  1825 days (5 year) random date from Today
  DateTime pastDate([int days=5*365]){
    final int randomDays = nextInt(days);
    final DateTime randomDate = DateTime.now().subtract(Duration(days: randomDays,seconds: nextInt(60*60*24)));
    return randomDate;
  }

  ///default 365*5 =  1825 days (5 year) random date  from Today
  DateTime futureDate([int days=5*365]){
    final int randomDays = nextInt(days);
    final DateTime randomDate = DateTime.now().add(Duration(days: randomDays,seconds: nextInt(60*60*24)));
    return randomDate;
  }
}