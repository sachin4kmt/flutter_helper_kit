/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

class MyCustomTextField extends StatelessWidget {
  final int? maxLength;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool readOnly;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final void Function(String? newValue)? onSaved;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool? ignorePointers;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;

  ///Decoration

  final String? labelText;
  final Widget? label;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final Duration? hintFadeDuration;
  final TextStyle? errorStyle;
  final int? errorMaxLines;
  final FloatingLabelBehavior floatingLabelBehavior;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isCollapsed;
  final Widget? icon;
  final Widget? prefix;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final Widget? prefixIcon;
  final Color? prefixColor;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final String? suffixText;

  final Widget? suffixIcon;
  final TextStyle? suffixStyle;
  final Color? suffixIconColor;
  final BoxConstraints? suffixIconConstraints;
  final TextStyle? counterStyle;
  final bool? filled;
  final Color? fillColor;
  final BorderSide? outlineBorder;
  final BorderSide? activeIndicatorBorder;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? errorBorderColor;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final InputBorder? border;
  final bool? alignLabelWithHint;
  final BoxConstraints? constraints;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;

  const MyCustomTextField({
    this.hintText,
    this.labelText,
    this.label,
    this.maxLength,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.enabled,
    this.ignorePointers,
    this.cursorWidth = 1.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.labelStyle,
    this.floatingLabelStyle,
    this.hintStyle,
    this.hintFadeDuration,
    this.errorStyle,
    this.errorMaxLines,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.floatingLabelAlignment,
    this.isDense,
    this.contentPadding,
    this.isCollapsed,
    this.icon,
    this.prefix,
    this.prefixText,
    this.prefixStyle,
    this.prefixIcon,
    this.prefixColor,
    this.prefixConstraints,
    this.suffix,
    this.suffixText,
    this.suffixIcon,
    this.suffixStyle,
    this.suffixIconColor,
    this.suffixIconConstraints,
    this.counterStyle,
    this.filled,
    this.fillColor,
    this.outlineBorder,
    this.activeIndicatorBorder,
    this.focusColor,
    this.hoverColor,
    this.errorBorderColor,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.enabledBorder,
    this.border,
    this.alignLabelWithHint,
    this.constraints,
    this.borderSide,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final inputDecor = context.theme.inputDecorationTheme;
    final customBorder = (border ??
        OutlineInputBorder(
            borderSide:
                borderSide ?? const BorderSide(color: Colors.transparent),
            borderRadius:
                borderRadius ?? const BorderRadius.all(Radius.circular(4))));
    final customErrorBorder = customBorder.copyWith(
        borderSide: customBorder.borderSide.copyWith(
            color: errorBorderColor ??
                inputDecor.errorBorder?.borderSide.color ??
                Colors.red));
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLength: maxLength,
      textCapitalization: textCapitalization,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        label: label,
        labelStyle: (labelStyle ?? const TextStyle())
            .copyWith(color: inputDecor.labelStyle?.color ?? Colors.grey),
        floatingLabelStyle: floatingLabelStyle,
        hintText: hintText,
        hintStyle: (hintStyle ?? const TextStyle())
            .copyWith(color: inputDecor.hintStyle?.color ?? Colors.grey),
        hintFadeDuration: hintFadeDuration,
        errorStyle: (errorStyle ?? const TextStyle()).copyWith(
            color:
                inputDecor.errorBorder?.borderSide.color ?? errorBorderColor),
        errorMaxLines: errorMaxLines,
        floatingLabelBehavior: floatingLabelBehavior,
        floatingLabelAlignment: floatingLabelAlignment,
        isDense: isDense,
        contentPadding:
            contentPadding ?? const EdgeInsets.fromLTRB(10, 10, 10, 10),
        icon: icon,
        isCollapsed: isCollapsed,
        prefix: prefix,
        prefixText: prefixText,
        prefixStyle: prefixStyle,
        prefixIcon: prefixIcon,
        prefixIconColor: prefixColor,
        // prefixIconConstraints: prefixConstraints,
        prefixIconConstraints: prefixConstraints ??
            (prefixIcon != null
                ? const BoxConstraints(minHeight: 0, minWidth: 0)
                : prefixConstraints),
        suffix: suffix,
        suffixText: suffixText,
        suffixIcon: suffixIcon,
        suffixStyle: suffixStyle,
        suffixIconColor: suffixIconColor,
        suffixIconConstraints: suffixIconConstraints ??
            (prefixIcon != null
                ? const BoxConstraints(minHeight: 0, minWidth: 0)
                : suffixIconConstraints),
        counterStyle: counterStyle,
        filled: filled,
        fillColor: fillColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        errorBorder: customErrorBorder,
        focusedBorder: customBorder.copyWith(
            borderSide: customBorder.borderSide.copyWith(
                color: focusColor ??
                    inputDecor.errorBorder?.borderSide.color ??
                    context.primaryColor)),
        focusedErrorBorder: customErrorBorder,
        disabledBorder: customBorder.copyWith(
            borderSide: customBorder.borderSide.copyWith(
                color: inputDecor.disabledBorder?.borderSide.color ??
                    Colors.grey)),
        enabledBorder: customBorder,
        border: customBorder,
        alignLabelWithHint: alignLabelWithHint,
        constraints: constraints,
      ),
      textInputAction: textInputAction,
      style: style,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      readOnly: readOnly,
      showCursor: showCursor,
      obscuringCharacter: obscuringCharacter,
      obscureText: obscureText,
      autocorrect: autocorrect,
      maxLines: maxLines,
      onTap: onTap,
      onTapOutside: onTapOutside ??
          (v) {
            context.unFocusKeyboard();
          },
      onEditingComplete: onEditingComplete,
      inputFormatters: inputFormatters,
      enabled: enabled,
      ignorePointers: ignorePointers,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      cursorErrorColor: cursorColor,
      keyboardAppearance: keyboardAppearance,
    );
  }
}
*/
