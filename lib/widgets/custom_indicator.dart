part of flutter_helper_kit;


class CustomIndicator extends StatelessWidget {
  final bool isActive;
  final Widget child;
  final double opacity;
  final Color bgColor;
  final Color indicatorColor;

  const CustomIndicator(
      {Key? key,
      this.indicatorColor = Colors.blue,
      this.isActive = false,
      required this.child,
      this.opacity = 0.6,
      this.bgColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isActive) {
      return child;
    }
    final widget = AbsorbPointer(child: child);

    return Stack(children: <Widget>[
      widget,
      if (opacity > 0.0)
        Opacity(
          opacity: 0.6,
          child: Container(
            color: Colors.grey,
          ),
        ),
      Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
        ),
      )
    ]);
  }
}