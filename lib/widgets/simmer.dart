import 'package:flutter/material.dart';

// ************************************defaultColorsList*************************
const List<Color> _defaultColors = [
  Color.fromRGBO(0, 0, 0, 0.1),
  Color(0x44CCCCCC),
  Color.fromRGBO(0, 0, 0, 0.1)
];

// ************************************defaultColorsListForText*************************
const List<Color> _textDefaultColors = [
  Color.fromRGBO(0, 0, 0, 0.1),
  Color(0x44CCCCCC),
  Color.fromRGBO(0, 0, 0, 0.1),
];

//
// **************************************_buildButtonBox**********************************
//
Widget _buildButtonBox(Animation animation,
    {required double width,
    required double height,
    required bool isDarkMode,
    required bool isRectBox,
    required bool isPurplishMode,
    required AlignmentGeometry beginAlign,
    required AlignmentGeometry endAlign,
    required bool hasCustomColors,
    required List<Color> colors,
    bool isVideoShimmer = false}) {
  return Container(
    margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
    height: isVideoShimmer ? width * 0.2 : width * 0.2,
    width: isVideoShimmer ? width * 0.25 : width * 0.2,
    decoration: _customBoxDecoration(
        animation: animation,
        isDarkMode: isDarkMode,
        isPurplishMode: isPurplishMode,
        isRectBox: isRectBox,
        beginAlign: beginAlign,
        endAlign: endAlign,
        hasCustomColors: hasCustomColors,
        colors: colors.length == 3 ? colors : _defaultColors),
  );
}
//
// **************************************_buildButtonBox**********************************
//

//
// **************************************CustomBoxDecoration****************************
// [animation]
// [isRectBox]
// [isDarkMode]
// [beginAlign]
// [endAlign]
//
Decoration _customBoxDecoration({
  required Animation animation,
  bool isRectBox = false,
  bool isDarkMode = false,
  bool isPurplishMode = false,
  bool hasCustomColors = false,
  List<Color> colors = _defaultColors,
  AlignmentGeometry beginAlign = Alignment.topLeft,
  AlignmentGeometry endAlign = Alignment.bottomRight,
}) {
  return BoxDecoration(
      shape: isRectBox ? BoxShape.rectangle : BoxShape.circle,
      gradient: LinearGradient(
          begin: beginAlign,
          end: endAlign,
          colors: hasCustomColors
              ? colors.map((color) {
                  return color;
                }).toList()
              : [
                  isPurplishMode
                      ? const Color(0xFF8D71A9)
                      : isDarkMode
                          ? const Color(0xFF1D1D1D)
                          : const Color.fromRGBO(0, 0, 0, 0.1),
                  isPurplishMode
                      ? const Color(0xFF36265A)
                      : isDarkMode
                          ? const Color(0XFF3C4042)
                          : const Color(0x44CCCCCC),
                  isPurplishMode
                      ? const Color(0xFF8D71A9)
                      : isDarkMode
                          ? const Color(0xFF1D1D1D)
                          : const Color.fromRGBO(0, 0, 0, 0.1),
                ],
          stops: [animation.value - 2, animation.value, animation.value + 1]));
}
//
// **************************************CustomBoxDecoration****************************
//
//

//
// **************************************CustomBoxDecoration****************************
// [animation]
// [isDarkMode]
// [beginAlign]
// [endAlign]
//
Decoration _radiusBoxDecoration(
    {required Animation animation,
    bool isDarkMode = false,
    bool isPurplishMode = false,
    bool hasCustomColors = false,
    AlignmentGeometry beginAlign = Alignment.topLeft,
    AlignmentGeometry endAlign = Alignment.bottomRight,
    List<Color> colors = _defaultColors,
    double radius = 10.0}) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      shape: BoxShape.rectangle,
      gradient: LinearGradient(
          begin: beginAlign,
          end: endAlign,
          colors: hasCustomColors
              ? colors.map((color) {
                  return color;
                }).toList()
              : [
                  isPurplishMode
                      ? const Color(0xFF8D71A9)
                      : isDarkMode
                          ? const Color(0xFF1D1D1D)
                          : const Color.fromRGBO(0, 0, 0, 0.1),
                  isPurplishMode
                      ? const Color(0xFF36265A)
                      : isDarkMode
                          ? const Color(0XFF3C4042)
                          : const Color(0x44CCCCCC),
                  isPurplishMode
                      ? const Color(0xFF8D71A9)
                      : isDarkMode
                          ? const Color(0xFF1D1D1D)
                          : const Color.fromRGBO(0, 0, 0, 0.1),
                ],
          stops: [animation.value - 2, animation.value, animation.value + 1]));
}
//
// **************************************CustomBoxDecoration****************************
//
//

// *************************************TextShimmer***************************
class TextShimmer extends StatefulWidget {
  final bool isDarkMode;
  final bool isPurplishMode;
  final bool hasCustomColors;
  final List<Color> colors;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final String? text;
  final double? fontSize;
  const TextShimmer({
    super.key,
    this.isDarkMode = false,
    this.isPurplishMode = false,
    this.hasCustomColors = true,
    this.colors = _textDefaultColors,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.centerRight,
    this.text,
    this.fontSize,
  });
  @override
  TextShimmerState createState() => TextShimmerState();
}

class TextShimmerState extends State<TextShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(
        curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose************************
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          return ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
                begin: widget.beginAlign,
                end: widget.endAlign,
                colors: widget.hasCustomColors
                    ? widget.colors.map((color) {
                        return color;
                      }).toList()
                    : widget.hasCustomColors
                        ? widget.colors
                        : [
                            widget.isPurplishMode
                                ? const Color(0xFF8D71A9)
                                : widget.isDarkMode
                                    ? const Color(0xFF1D1D1D)
                                    : const Color.fromRGBO(0, 0, 0, 0.1),
                            widget.isPurplishMode
                                ? const Color(0xFF36265A)
                                : widget.isDarkMode
                                    ? const Color(0XFF3C4042)
                                    : const Color(0x44CCCCCC),
                            widget.isPurplishMode
                                ? const Color(0xFF8D71A9)
                                : widget.isDarkMode
                                    ? const Color(0xFF1D1D1D)
                                    : const Color.fromRGBO(0, 0, 0, 0.1),
                          ],
                stops: [
                  _animation.value + 2,
                  _animation.value,
                  _animation.value - 2,
                ]).createShader(bounds),
            child: const Text(
              'Testing Shimmer..................',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          );
        });
  }
}
// *************************************TextShimmer***************************

//
//  ***************************ProfileShimmer******************************
// *[isRectBox] when it is true then it will show Rectancle shape else(false) show circle shape by defult its value false
// *[isDarkMode]when it is true then it will use black bg color otherwise it use transparent color by defult its value false
// *[isDisabledAvatar]: when it is true then it will hide circle avatar by default it's false
// *[beginAlign] it will set the begin value for gradientColor by defult its value Alignment.topLeft
// *[endAlign]   it will set the end value for gradientColor by defult its value Alignment.bottomRight
// *[hasBottomLines] when it is true then it will show bottom lines otherwise its hide the lines by defult its value false
// *[padding] it wiil set the padding of parent container by default its value 16.0 from all side(left,right,top,bottom)
// *[margin] it wiil set the margin of parent container by default its value 16.0 from all side(left,right,top,bottom)
//
//
class ProfileShimmer extends StatefulWidget {
  final bool isRectBox;
  final bool isDarkMode;
  final bool isPurplishMode;
  final bool isDisabledAvatar;
  final bool hasCustomColors;
  final List<Color> colors;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final bool hasBottomLines;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color bgColor;

  const ProfileShimmer({
    super.key,
    this.isRectBox = false,
    this.isDarkMode = false,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.bottomRight,
    this.hasBottomLines = false,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(16.0),
    this.isPurplishMode = false,
    this.hasCustomColors = false,
    this.colors = _defaultColors,
    this.isDisabledAvatar = false,
    this.bgColor = Colors.transparent,
  });
  @override
  ProfileShimmerState createState() => ProfileShimmerState();
}

class ProfileShimmerState extends State<ProfileShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(
        curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose************************
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          color: widget.isDarkMode ? const Color(0xFF0B0B0B) : widget.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  widget.isDisabledAvatar
                      ? Container()
                      : Container(
                          height: width * 0.14,
                          width: width * 0.14,
                          decoration: _customBoxDecoration(
                              animation: _animation,
                              isRectBox: widget.isRectBox,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3
                                  ? widget.colors
                                  : _defaultColors),
                        ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: width * 0.13,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: height * 0.008,
                          width: widget.isDisabledAvatar
                              ? width * 0.4
                              : width * 0.3,
                          decoration: _radiusBoxDecoration(
                              animation: _animation,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3
                                  ? widget.colors
                                  : _defaultColors),
                        ),
                        Container(
                          height: height * 0.006,
                          width: widget.isDisabledAvatar
                              ? width * 0.3
                              : width * 0.2,
                          decoration: _radiusBoxDecoration(
                              animation: _animation,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3
                                  ? widget.colors
                                  : _defaultColors),
                        ),
                        Container(
                          height: height * 0.007,
                          width: widget.isDisabledAvatar
                              ? width * 0.5
                              : width * 0.4,
                          decoration: _radiusBoxDecoration(
                              animation: _animation,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3
                                  ? widget.colors
                                  : _defaultColors),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              widget.hasBottomLines
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          height: height * 0.006,
                          width: width * 0.7,
                          decoration: _radiusBoxDecoration(
                              animation: _animation,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3
                                  ? widget.colors
                                  : _defaultColors),
                        ),
                        Container(
                          height: height * 0.006,
                          width: width * 0.8,
                          decoration: _radiusBoxDecoration(
                              animation: _animation,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3
                                  ? widget.colors
                                  : _defaultColors),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: height * 0.006,
                          width: width * 0.5,
                          decoration: _radiusBoxDecoration(
                              animation: _animation,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3
                                  ? widget.colors
                                  : _defaultColors),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
//
//  ***************************ProfileShimmer******************************
//

//
//  ***************************ProfilePageShimmer******************************
// *[isRectBox] when it is true then it will show Rectancle shape else(false) show circle shape by defult its value false
// *[isDarkMode]when it is true then it will use black bg color otherwise it use transparent color by defult its value false
// *[isDisabledAvatar]: when it is true then it will hide circle avatar by default it's false
// *[beginAlign] it will set the begin value for gradientColor by defult its value Alignment.topLeft
// *[endAlign]   it will set the end value for gradientColor by defult its value Alignment.bottomRight
// *[hasBottomBox] when it is true then it will show bottom Rect style Boxes otherwise its hide the Boxes by defult its value false
// *[padding] it wiil set the padding of parent container by default its value 16.0 from all side(left,right,top,bottom)
// *[margin] it wiil set the margin of parent container by default its value 16.0 from all side(left,right,top,bottom)
//
//
//
class ProfilePageShimmer extends StatefulWidget {
  final bool isRectBox;
  final bool isDarkMode;
  final bool isPurplishMode;
  final bool isDisabledAvatar;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final bool hasBottomBox;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool hasCustomColors;
  final List<Color> colors;
  final Color bgColor;
  const ProfilePageShimmer({
    super.key,
    this.isRectBox = false,
    this.isDarkMode = false,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.bottomRight,
    this.hasBottomBox = false,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(16.0),
    this.isPurplishMode = false,
    this.hasCustomColors = false,
    this.colors = _defaultColors,
    this.isDisabledAvatar = false,
    this.bgColor = Colors.transparent,
  });
  @override
  ProfilePageShimmerState createState() => ProfilePageShimmerState();
}

class ProfilePageShimmerState extends State<ProfilePageShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(
        curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose************************
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          color: widget.isDarkMode ? const Color(0xFF0B0B0B) : widget.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.isDisabledAvatar
                  ? Container()
                  : _buildButtonBox(_animation,
                      height: width,
                      width: width,
                      isPurplishMode: widget.isPurplishMode,
                      isDarkMode: widget.isDarkMode,
                      isRectBox: widget.isRectBox,
                      beginAlign: widget.beginAlign,
                      endAlign: widget.endAlign,
                      hasCustomColors: widget.hasCustomColors,
                      colors: widget.colors.length == 3
                          ? widget.colors
                          : _defaultColors),
              Container(
                height: height * 0.006,
                width: width * 0.8,
                decoration: _radiusBoxDecoration(
                    animation: _animation,
                    isPurplishMode: widget.isPurplishMode,
                    isDarkMode: widget.isDarkMode,
                    hasCustomColors: widget.hasCustomColors,
                    colors: widget.colors.length == 3
                        ? widget.colors
                        : _defaultColors),
              ),
              const SizedBox(height: 10),
              Container(
                height: height * 0.006,
                width: width * 0.5,
                decoration: _radiusBoxDecoration(
                    animation: _animation,
                    isPurplishMode: widget.isPurplishMode,
                    isDarkMode: widget.isDarkMode,
                    hasCustomColors: widget.hasCustomColors,
                    colors: widget.colors.length == 3
                        ? widget.colors
                        : _defaultColors),
              ),
              widget.hasBottomBox
                  ? Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildButtonBox(_animation,
                                height: width,
                                width: width,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                isRectBox: true,
                                beginAlign: widget.beginAlign,
                                endAlign: widget.endAlign,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                            _buildButtonBox(_animation,
                                height: width,
                                width: width,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                isRectBox: true,
                                beginAlign: widget.beginAlign,
                                endAlign: widget.endAlign,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                            _buildButtonBox(_animation,
                                height: width,
                                width: width,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                isRectBox: true,
                                beginAlign: widget.beginAlign,
                                endAlign: widget.endAlign,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildButtonBox(_animation,
                                height: width,
                                width: width,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                isRectBox: true,
                                beginAlign: widget.beginAlign,
                                endAlign: widget.endAlign,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                            _buildButtonBox(_animation,
                                height: width,
                                width: width,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                isRectBox: true,
                                beginAlign: widget.beginAlign,
                                endAlign: widget.endAlign,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                            _buildButtonBox(_animation,
                                height: width,
                                width: width,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                isRectBox: true,
                                beginAlign: widget.beginAlign,
                                endAlign: widget.endAlign,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                          ],
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
//
//  ***************************ProfilePageShimmer******************************
//

//
//  ***************************VideoShimmer******************************
// *[isRectBox] when it is true then it will show Rectancle shape else(false) show circle shape by defult its value false
// *[isDarkMode]when it is true then it will use black bg color otherwise it use transparent color by defult its value false
// *[beginAlign] it will set the begin value for gradientColor by defult its value Alignment.topLeft
// *[endAlign]   it will set the end value for gradientColor by defult its value Alignment.bottomRight
// *[hasBottomBox] when it is true then it will show bottom Rect style Boxes otherwise its hide the Boxes by defult its value false
// *[padding] it wiil set the padding of parent container by default its value 16.0 from all side(left,right,top,bottom)
// *[margin] it wiil set the margin of parent container by default its value 16.0 from all side(left,right,top,bottom)
//
//
//
class VideoShimmer extends StatefulWidget {
  final bool isRectBox;
  final bool isDarkMode;
  final bool isPurplishMode;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final bool hasBottomBox;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool hasCustomColors;
  final List<Color> colors;
  final Color bgColor;
  const VideoShimmer({
    super.key,
    this.isRectBox = false,
    this.isDarkMode = false,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.bottomRight,
    this.hasBottomBox = false,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(16.0),
    this.isPurplishMode = false,
    this.hasCustomColors = false,
    this.colors = _defaultColors,
    this.bgColor = Colors.transparent,
  });
  @override
  VideoShimmerState createState() => VideoShimmerState();
}

class VideoShimmerState extends State<VideoShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(
        curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose************************
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          color: widget.isDarkMode ? const Color(0xFF0B0B0B) : widget.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _buildButtonBox(_animation,
                          height: width,
                          width: width,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          isRectBox: true,
                          beginAlign: widget.beginAlign,
                          endAlign: widget.endAlign,
                          isVideoShimmer: true,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3
                              ? widget.colors
                              : _defaultColors),
                      Container(
                        height: height * 0.006,
                        width: width * 0.2,
                        decoration: _radiusBoxDecoration(
                            animation: _animation,
                            isPurplishMode: widget.isPurplishMode,
                            isDarkMode: widget.isDarkMode,
                            hasCustomColors: widget.hasCustomColors,
                            colors: widget.colors.length == 3
                                ? widget.colors
                                : _defaultColors),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      _buildButtonBox(_animation,
                          height: width,
                          width: width,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          isRectBox: true,
                          beginAlign: widget.beginAlign,
                          endAlign: widget.endAlign,
                          isVideoShimmer: true,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3
                              ? widget.colors
                              : _defaultColors),
                      Container(
                        height: height * 0.006,
                        width: width * 0.2,
                        decoration: _radiusBoxDecoration(
                            animation: _animation,
                            isPurplishMode: widget.isPurplishMode,
                            isDarkMode: widget.isDarkMode,
                            hasCustomColors: widget.hasCustomColors,
                            colors: widget.colors.length == 3
                                ? widget.colors
                                : _defaultColors),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      _buildButtonBox(_animation,
                          height: width,
                          width: width,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          isRectBox: true,
                          beginAlign: widget.beginAlign,
                          endAlign: widget.endAlign,
                          isVideoShimmer: true,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3
                              ? widget.colors
                              : _defaultColors),
                      Container(
                        height: height * 0.006,
                        width: width * 0.2,
                        decoration: _radiusBoxDecoration(
                            animation: _animation,
                            isPurplishMode: widget.isPurplishMode,
                            isDarkMode: widget.isDarkMode,
                            hasCustomColors: widget.hasCustomColors,
                            colors: widget.colors.length == 3
                                ? widget.colors
                                : _defaultColors),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
//
//  ***************************VideoShimmer******************************
//

//  ***************************VideoShimmer******************************
// *[isRectBox] when it is true then it will show Rectancle shape else(false) show circle shape by defult its value false
// *[isDarkMode]when it is true then it will use black bg color otherwise it use transparent color by defult its value false
// *[beginAlign] it will set the begin value for gradientColor by defult its value Alignment.topLeft
// *[endAlign]   it will set the end value for gradientColor by defult its value Alignment.bottomRight
// *[hasBottomBox] when it is true then it will show bottom Rect style Boxes otherwise its hide the Boxes by defult its value false
// *[padding] it wiil set the padding of parent container by default its value 16.0 from all side(left,right,top,bottom)
// *[margin] it wiil set the margin of parent container by default its value 16.0 from all side(left,right,top,bottom)
//
//
//
class YoutubeShimmer extends StatefulWidget {
  final bool isRectBox;
  final bool isDarkMode;
  final bool isPurplishMode;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final bool hasBottomBox;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool hasCustomColors;
  final List<Color> colors;
  final Color bgColor;
  const YoutubeShimmer({
    super.key,
    this.isRectBox = false,
    this.isDarkMode = false,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.bottomRight,
    this.hasBottomBox = false,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(16.0),
    this.isPurplishMode = false,
    this.hasCustomColors = false,
    this.colors = _defaultColors,
    this.bgColor = Colors.transparent,
  });
  @override
  YoutubeShimmerState createState() => YoutubeShimmerState();
}

class YoutubeShimmerState extends State<YoutubeShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(
        curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose************************
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          color: widget.isDarkMode ? const Color(0xFF0B0B0B) : widget.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildButtonBox(_animation,
                          height: width,
                          width: width,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          isRectBox: true,
                          beginAlign: widget.beginAlign,
                          endAlign: widget.endAlign,
                          isVideoShimmer: true,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3
                              ? widget.colors
                              : _defaultColors),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: width * 0.05,
                            width: width * 0.05,
                            decoration: _customBoxDecoration(
                                animation: _animation,
                                isRectBox: widget.isRectBox,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            children: <Widget>[
                              Container(
                                height: width * 0.01,
                                width: width * 0.12,
                                decoration: _radiusBoxDecoration(
                                    animation: _animation,
                                    isPurplishMode: widget.isPurplishMode,
                                    isDarkMode: widget.isDarkMode,
                                    hasCustomColors: widget.hasCustomColors,
                                    colors: widget.colors.length == 3
                                        ? widget.colors
                                        : _defaultColors),
                              ),
                              const SizedBox(height: 6.0),
                              Container(
                                height: width * 0.01,
                                width: width * 0.12,
                                decoration: _radiusBoxDecoration(
                                    animation: _animation,
                                    isPurplishMode: widget.isPurplishMode,
                                    isDarkMode: widget.isDarkMode,
                                    hasCustomColors: widget.hasCustomColors,
                                    colors: widget.colors.length == 3
                                        ? widget.colors
                                        : _defaultColors),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildButtonBox(_animation,
                          height: width,
                          width: width,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          isRectBox: true,
                          beginAlign: widget.beginAlign,
                          endAlign: widget.endAlign,
                          isVideoShimmer: true,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3
                              ? widget.colors
                              : _defaultColors),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: width * 0.05,
                            width: width * 0.05,
                            decoration: _customBoxDecoration(
                                animation: _animation,
                                isRectBox: widget.isRectBox,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            children: <Widget>[
                              Container(
                                height: width * 0.01,
                                width: width * 0.12,
                                decoration: _radiusBoxDecoration(
                                    animation: _animation,
                                    isPurplishMode: widget.isPurplishMode,
                                    isDarkMode: widget.isDarkMode,
                                    hasCustomColors: widget.hasCustomColors,
                                    colors: widget.colors.length == 3
                                        ? widget.colors
                                        : _defaultColors),
                              ),
                              const SizedBox(height: 6.0),
                              Container(
                                height: width * 0.01,
                                width: width * 0.12,
                                decoration: _radiusBoxDecoration(
                                    animation: _animation,
                                    isPurplishMode: widget.isPurplishMode,
                                    isDarkMode: widget.isDarkMode,
                                    hasCustomColors: widget.hasCustomColors,
                                    colors: widget.colors.length == 3
                                        ? widget.colors
                                        : _defaultColors),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildButtonBox(_animation,
                          height: width,
                          width: width,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          isRectBox: true,
                          beginAlign: widget.beginAlign,
                          endAlign: widget.endAlign,
                          isVideoShimmer: true,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3
                              ? widget.colors
                              : _defaultColors),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: width * 0.05,
                            width: width * 0.05,
                            decoration: _customBoxDecoration(
                                animation: _animation,
                                isRectBox: widget.isRectBox,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            children: <Widget>[
                              Container(
                                height: width * 0.01,
                                width: width * 0.12,
                                decoration: _radiusBoxDecoration(
                                    animation: _animation,
                                    isPurplishMode: widget.isPurplishMode,
                                    isDarkMode: widget.isDarkMode,
                                    hasCustomColors: widget.hasCustomColors,
                                    colors: widget.colors.length == 3
                                        ? widget.colors
                                        : _defaultColors),
                              ),
                              const SizedBox(height: 6.0),
                              Container(
                                height: width * 0.01,
                                width: width * 0.12,
                                decoration: _radiusBoxDecoration(
                                    animation: _animation,
                                    isPurplishMode: widget.isPurplishMode,
                                    isDarkMode: widget.isDarkMode,
                                    hasCustomColors: widget.hasCustomColors,
                                    colors: widget.colors.length == 3
                                        ? widget.colors
                                        : _defaultColors),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

//
//  ***************************ListTileShimmer******************************
//
// *[isRectBox] when it is true then it will show Rectancle shape else(false) show circle shape by defult its value false
// *[isDarkMode]when it is true then it will use black bg color otherwise it use transparent color by defult its value false
// *[isDisabledAvatar]: when it is true then it will hide circle avatar by default it's false
// *[isDisabledButton]: when it's true then it will hide right side button shape shimmer
// *[beginAlign] it will set the begin value for gradientColor by defult its value Alignment.topLeft
// *[endAlign]   it will set the end value for gradientColor by defult its value Alignment.bottomRight
// *[hasBottomBox] when it is true then it will show bottom Rect style Boxes otherwise its hide the Boxes by defult its value false
// *[padding] it wiil set the padding of parent container by default its value 16.0 from all side(left,right,top,bottom)
// *[margin] it wiil set the margin of parent container by default its value 16.0 from all side(left,right,top,bottom)
//
//
//
class ListTileShimmer extends StatefulWidget {
  final bool isRectBox;
  final bool isDarkMode;
  final bool isPurplishMode;
  final bool isDisabledAvatar;
  final bool isDisabledButton;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final bool hasBottomBox;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool hasCustomColors;
  final bool onlyShowProfilePicture;
  final List<Color> colors;
  final double height;
  final Color bgColor;
  const ListTileShimmer({
    super.key,
    this.isRectBox = false,
    this.isDarkMode = false,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.bottomRight,
    this.hasBottomBox = false,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(16.0),
    this.isPurplishMode = false,
    this.hasCustomColors = false,
    this.colors = _defaultColors,
    this.isDisabledAvatar = false,
    this.isDisabledButton = false,
    this.onlyShowProfilePicture = false,
    this.height = 0,
    this.bgColor = Colors.transparent,
  });
  @override
  ListTileShimmerState createState() => ListTileShimmerState();
}

class ListTileShimmerState extends State<ListTileShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(
        curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose*********************  ***
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        var newHeight = widget.height * 2;
        var circleHeight = widget.height * 3;
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          color: widget.isDarkMode ? const Color(0xFF0B0B0B) : widget.bgColor,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  widget.onlyShowProfilePicture
                      ? Container(
                          height:
                              widget.height == 0 ? width * 0.1 : circleHeight,
                          width:
                              widget.height == 0 ? width * 0.1 : circleHeight,
                          decoration: _customBoxDecoration(
                              animation: _animation,
                              isRectBox: widget.isRectBox,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3
                                  ? widget.colors
                                  : _defaultColors),
                        )
                      : Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                widget.isDisabledAvatar
                                    ? Container()
                                    : Container(
                                        height: widget.height == 0
                                            ? width * 0.1
                                            : circleHeight,
                                        width: widget.height == 0
                                            ? width * 0.1
                                            : circleHeight,
                                        decoration: _customBoxDecoration(
                                            animation: _animation,
                                            isRectBox: widget.isRectBox,
                                            isPurplishMode:
                                                widget.isPurplishMode,
                                            isDarkMode: widget.isDarkMode,
                                            hasCustomColors:
                                                widget.hasCustomColors,
                                            colors: widget.colors.length == 3
                                                ? widget.colors
                                                : _defaultColors),
                                      ),
                                const SizedBox(width: 12.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: widget.height == 0
                                          ? width * 0.01
                                          : widget.height,
                                      width: widget.isDisabledAvatar &&
                                              widget.isDisabledButton
                                          ? width * 0.75
                                          : widget.isDisabledAvatar
                                              ? width * 0.6
                                              : widget.isDisabledButton
                                                  ? width * 0.6
                                                  : width * 0.5,
                                      decoration: _radiusBoxDecoration(
                                          animation: _animation,
                                          isPurplishMode: widget.isPurplishMode,
                                          isDarkMode: widget.isDarkMode,
                                          hasCustomColors:
                                              widget.hasCustomColors,
                                          colors: widget.colors.length == 3
                                              ? widget.colors
                                              : _defaultColors),
                                    ),
                                    const SizedBox(height: 6.0),
                                    Container(
                                      height: widget.height == 0
                                          ? width * 0.01
                                          : widget.height,
                                      width: width * 0.45,
                                      decoration: _radiusBoxDecoration(
                                          animation: _animation,
                                          isPurplishMode: widget.isPurplishMode,
                                          isDarkMode: widget.isDarkMode,
                                          hasCustomColors:
                                              widget.hasCustomColors,
                                          colors: widget.colors.length == 3
                                              ? widget.colors
                                              : _defaultColors),
                                    ),
                                  ],
                                ),
                                widget.isDisabledButton
                                    ? Container()
                                    : Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10.0),
                                          height: widget.height == 0
                                              ? width * 0.05
                                              : newHeight,
                                          width: width * 0.12,
                                          decoration: _radiusBoxDecoration(
                                              animation: _animation,
                                              isPurplishMode:
                                                  widget.isPurplishMode,
                                              isDarkMode: widget.isDarkMode,
                                              hasCustomColors:
                                                  widget.hasCustomColors,
                                              colors: widget.colors.length == 3
                                                  ? widget.colors
                                                  : _defaultColors),
                                        ),
                                      )
                              ],
                            )
                          ],
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

//
// **************************************PlayStoreShimmer****************************
//
// [beginAlign] it will set the begin value for gradientColor by defult its value Alignment.topLeft
// [endAlign]   it will set the end value for gradientColor by defult its value Alignment.bottomRight
// [padding] it wiil set the padding of parent container by default its value 16.0 from all side(left,right,top,bottom)
// [margin] it wiil set the margin of parent container by default its value 16.0 from all side(left,right,top,bottom)
class PlayStoreShimmer extends StatefulWidget {
  final bool isDarkMode;
  final bool isPurplishMode;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool hasCustomColors;
  final bool hasBottomFirstLine;
  final bool hasBottomSecondLine;
  final List<Color> colors;
  final ScrollPhysics physics;
  final Color bgColor;

  const PlayStoreShimmer(
      {super.key,
      this.isDarkMode = false,
      this.isPurplishMode = false,
      this.beginAlign = Alignment.topLeft,
      this.endAlign = Alignment.bottomRight,
      this.padding = const EdgeInsets.all(16.0),
      this.margin = const EdgeInsets.all(16.0),
      this.hasCustomColors = false,
      this.colors = _defaultColors,
      this.hasBottomFirstLine = true,
      this.hasBottomSecondLine = true,
      this.physics = const BouncingScrollPhysics(),
      this.bgColor = Colors.transparent});
  @override
  PlayStoreShimmerState createState() => PlayStoreShimmerState();
}

class PlayStoreShimmerState extends State<PlayStoreShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // * init
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(
        curve: Curves.easeInOutSine, parent: _animationController));
  }

  // ***dispose
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: widget.physics,
          child: Container(
            margin: widget.margin,
            padding: widget.padding,
            color: widget.isDarkMode ? const Color(0xFF0B0B0B) : widget.bgColor,
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 110,
                      decoration: _radiusBoxDecoration(
                          radius: 25.0,
                          animation: _animation,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3
                              ? widget.colors
                              : _defaultColors),
                    ),
                    const SizedBox(height: 10.0),
                    widget.hasBottomFirstLine
                        ? Container(
                            height: width * 0.024,
                            width: 110,
                            decoration: _radiusBoxDecoration(
                                radius: 0.0,
                                animation: _animation,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                          )
                        : Container(),
                    const SizedBox(height: 10.0),
                    widget.hasBottomSecondLine
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: _radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3
                                          ? widget.colors
                                          : _defaultColors),
                                ),
                              ),
                              Container(
                                width: 30,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: _radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3
                                          ? widget.colors
                                          : _defaultColors),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 110,
                      decoration: _radiusBoxDecoration(
                          radius: 25.0,
                          animation: _animation,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3
                              ? widget.colors
                              : _defaultColors),
                    ),
                    const SizedBox(height: 10.0),
                    widget.hasBottomFirstLine
                        ? Container(
                            height: width * 0.024,
                            width: 110,
                            decoration: _radiusBoxDecoration(
                                radius: 0.0,
                                animation: _animation,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                          )
                        : Container(),
                    const SizedBox(height: 10.0),
                    widget.hasBottomSecondLine
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: _radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3
                                          ? widget.colors
                                          : _defaultColors),
                                ),
                              ),
                              Container(
                                width: 30,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: _radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3
                                          ? widget.colors
                                          : _defaultColors),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 110,
                      decoration: _radiusBoxDecoration(
                          radius: 25.0,
                          animation: _animation,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3
                              ? widget.colors
                              : _defaultColors),
                    ),
                    const SizedBox(height: 10.0),
                    widget.hasBottomFirstLine
                        ? Container(
                            height: width * 0.024,
                            width: 110,
                            decoration: _radiusBoxDecoration(
                                radius: 0.0,
                                animation: _animation,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                          )
                        : Container(),
                    const SizedBox(height: 10.0),
                    widget.hasBottomSecondLine
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: _radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3
                                          ? widget.colors
                                          : _defaultColors),
                                ),
                              ),
                              Container(
                                width: 30,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: _radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3
                                          ? widget.colors
                                          : _defaultColors),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 110,
                      decoration: _radiusBoxDecoration(
                          radius: 25.0,
                          animation: _animation,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3
                              ? widget.colors
                              : _defaultColors),
                    ),
                    const SizedBox(height: 10.0),
                    widget.hasBottomFirstLine
                        ? Container(
                            height: width * 0.024,
                            width: 110,
                            decoration: _radiusBoxDecoration(
                                radius: 0.0,
                                animation: _animation,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                          )
                        : Container(),
                    const SizedBox(height: 10.0),
                    widget.hasBottomSecondLine
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: _radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3
                                          ? widget.colors
                                          : _defaultColors),
                                ),
                              ),
                              Container(
                                width: 30,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: _radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3
                                          ? widget.colors
                                          : _defaultColors),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 110,
                      decoration: _radiusBoxDecoration(
                          radius: 25.0,
                          animation: _animation,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3
                              ? widget.colors
                              : _defaultColors),
                    ),
                    const SizedBox(height: 10.0),
                    widget.hasBottomFirstLine
                        ? Container(
                            height: width * 0.024,
                            width: 110,
                            decoration: _radiusBoxDecoration(
                                radius: 0.0,
                                animation: _animation,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : _defaultColors),
                          )
                        : Container(),
                    const SizedBox(height: 10.0),
                    widget.hasBottomSecondLine
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: _radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3
                                          ? widget.colors
                                          : _defaultColors),
                                ),
                              ),
                              Container(
                                width: 30,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: _radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3
                                          ? widget.colors
                                          : _defaultColors),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
// **************************************PlayStoreShimmer****************************
