part of flutter_helper_kit;

///
/// This widget wraps the main content of your app and listens for back button presses.
/// If the back button is pressed once, it shows a message (optional) and waits for another press.
/// If the back button is pressed twice within a short time frame (default is 2 seconds),
/// it exits the app.
///


DateTime? _currentBackPressTime;

class DoublePressBackWidget extends StatelessWidget {
  /// The main content of the app.
  final Widget child;

  /// The message to be shown when the back button is pressed once.
  ///
  /// Defaults to 'Press back again to exit'.
  final String? message;

  /// Callback function to be called when the back button is pressed.
  ///
  /// This function will be called before showing the message.
  final WillPopCallback? onWillPop;

  /// Creates a DoublePressBackWidget.
  ///
  /// The [child] parameter is required and represents the main content of the app.
  /// The [message] parameter is optional and represents the message to be shown when the back button is pressed once.
  /// The [onWillPop] parameter is optional and represents a callback function to be called when the back button is pressed.
  const DoublePressBackWidget({
    Key? key,
    required this.child,
    this.message,
    this.onWillPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () {
        DateTime now = DateTime.now();

        onWillPop?.call();
        if (_currentBackPressTime == null ||
            now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
          _currentBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message ?? 'Press back again to exit'),
              duration: const Duration(milliseconds: 1500),
            ),
          );

          return Future.value(false);
        }
        return Future.value(true);
      },
    );
  }
}