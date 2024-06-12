part of flutter_helper_kit;

/// A widget that displays its child in a scrolling manner.
///
/// The `Marquee` widget scrolls its child horizontally or vertically based on the
/// specified [direction]. It continuously scrolls the child in one or two directions
/// based on the [directionMarguee] property.
///

enum DirectionMarguee { oneDirection, twoDirection }

class Marquee extends StatelessWidget {
  /// The widget to display inside the Marquee.
  final Widget child;

  /// The direction in which the Marquee scrolls.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis direction;

  /// The direction of text, useful for internationalized text.
  ///
  /// Defaults to [TextDirection.ltr].
  final TextDirection textDirection;

  /// The duration of the animation for scrolling the child.
  ///
  /// Defaults to 5000 milliseconds.
  final Duration animationDuration;

  /// The duration of the animation for scrolling the child back.
  ///
  /// Defaults to 5000 milliseconds.
  final Duration backDuration;

  /// The duration to pause between scrolls.
  ///
  /// Defaults to 2000 milliseconds.
  final Duration pauseDuration;

  /// The direction of the Marquee scrolling.
  ///
  /// Defaults to [DirectionMarguee.twoDirection], which allows scrolling in both directions.
  final DirectionMarguee directionMarguee;

  /// Creates a Marquee widget.
  ///
  /// The [child] argument must not be null.
  Marquee({
    required this.child,
    this.direction = Axis.horizontal,
    this.textDirection = TextDirection.ltr,
    this.animationDuration = const Duration(milliseconds: 5000),
    this.backDuration = const Duration(milliseconds: 5000),
    this.pauseDuration = const Duration(milliseconds: 2000),
    this.directionMarguee = DirectionMarguee.twoDirection,
    Key? key,
  }) : super(key: key);

  final ScrollController scrollController = ScrollController();

  scroll() async {
    while (true) {
      if (scrollController.hasClients) {
        await Future.delayed(pauseDuration);
        if (scrollController.hasClients) {
          await scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: animationDuration,
              curve: Curves.easeIn);
        }
        await Future.delayed(pauseDuration);
        if (scrollController.hasClients) {
          switch (directionMarguee) {
            case DirectionMarguee.oneDirection:
              scrollController.jumpTo(
                0.0,
              );
              break;
            case DirectionMarguee.twoDirection:
              await scrollController.animateTo(0.0,
                  duration: backDuration, curve: Curves.easeOut);
              break;
          }
        }
      } else {
        await Future.delayed(pauseDuration);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    scroll();
    return Directionality(
      textDirection: textDirection,
      child: SingleChildScrollView(
        scrollDirection: direction,
        controller: scrollController,
        child: child,
      ),
    );
  }
}
