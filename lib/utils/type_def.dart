part of flutter_helper_kit;

///  Define a function that returns a Future<void> and takes no arguments
typedef FutureVoidCallback = Future<void> Function();

///  Define a function that returns a Future<dynamic> and takes no arguments
typedef FutureDynamicCallback = Future<dynamic> Function();

/// Define a function that returns a Future<int> and takes no arguments
typedef FutureIntCallback = Future<int> Function();

/// Define a function that returns a Future<String> and takes no arguments
typedef FutureStringCallback = Future<String> Function();

/// Define a function that returns a Future<double> and takes no arguments
typedef FutureDoubleCallback = Future<double> Function();

/// Define a function that returns a dynamic and takes no arguments
typedef DynamicCallback = dynamic Function();

/// Define a function that returns an int and takes no arguments
typedef IntCallback = int Function();

/// Define a function that returns a String and takes no arguments
typedef StringCallback = String Function();

/// Define a function that returns a double and takes no arguments
typedef DoubleCallback = double Function();

/// Define a function that takes a String argument and returns void
typedef StringArgVoidCallback = void Function(String arg);

/// Define a function that takes an int argument and returns void
typedef IntArgVoidCallback = void Function(int arg);

/// Define a function that takes a double argument and returns void
typedef DoubleArgVoidCallback = void Function(double arg);

/// Define a function that takes a bool argument and returns void
typedef BoolArgVoidCallback = void Function(bool arg);

/// Define a function that takes a dynamic argument and returns void
typedef DynamicArgVoidCallback = void Function(dynamic arg);
