part of flutter_helper_kit;


/// Checks if a string matches a specified pattern.
///
/// This function returns `true` if the [s] string matches the specified regular expression pattern [p].
/// If the [s] string is `null`, it returns `false`.
bool hasMatch(String? s, String p) => (s == null) ? false : RegExp(p).hasMatch(s);


/// Generates a random alphanumeric string with a random length between 1 and 64.
///
/// This function generates a random string with both alphabetical and numeric characters.
/// The length of the generated string is random and can be specified using the optional [length] parameter.
/// If [includeNumeric] is set to `false`, the generated string will only contain alphabetical characters.
String randomString({int? length, bool includeNumeric = true}) {
  var rand = math.Random();

  int generator(int i) {
    var charCount = includeNumeric ? 62 : 52;
    var start = includeNumeric ? 48 : 58;
    var charCode = rand.nextInt(charCount) + start;
    if (charCode.between(58, 64)) {
      charCode += 52;
    } else if (charCode.between(91, 96)) {
      charCode += 26;
    }
    return charCode;
  }

  length ??= rand.nextInt(64) + 1;
  return String.fromCharCodes(List.generate(length, generator));
}



