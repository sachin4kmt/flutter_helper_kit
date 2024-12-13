import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

/// Enum for Text Field
enum TextFieldType {
  email,
  emailEnhanced,
  password,
  name,
  multiline,
  other,
  phone,
  url,
  number,
  userName
}
// const _errorThisFieldRequired = 'This field is required';

/// Default Text Form Field
///
/// ChatGPT Parameters:
/// - `enableChatGPT`: A flag to enable or disable the ChatGPT feature.
/// - `promptFieldInputDecoration`: Custom input decoration for the prompt field in the chatGpt widget.
/// - `suffixChatGPTIcon`: An optional widget to be displayed as a suffix icon in the ChatGPT input field.
/// - `loadingChatGPT`: An optional widget to be displayed as a loading indicator during ChatGPT response generation.
/// - `shortReply`: If true, it will generate a 1-2 line reply. Default is false.
/// - `testWithoutKey`: If true, it will provide a static test response without using the actual API key. Default is false.
///
class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextFieldType textFieldType;

  final InputDecoration? decoration;
  final FocusNode? focus;
  final FormFieldValidator<String>? validator;
  final bool isValidationRequired;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final FocusNode? nextFocus;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final bool autoFocus;
  final bool readOnly;
  final bool? enableSuggestions;
  final int? maxLength;
  final Color? cursorColor;
  final Widget? suffix;
  final Color? suffixIconColor;
  final TextInputType? keyboardType;
  final Iterable<String>? autoFillHints;
  final EdgeInsets? scrollPadding;
  final double? cursorWidth;
  final double? cursorHeight;
  final Function()? onTap;
  final InputCounterWidgetBuilder? buildCounter;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlignVertical? textAlignVertical;
  final bool expands;
  final bool? showCursor;
  final TextSelectionControls? selectionControls;
  final StrutStyle? strutStyle;
  final String obscuringCharacter;
  final String? initialValue;
  final Brightness? keyboardAppearance;
  final Widget? suffixPasswordVisibleWidget;
  final Widget? suffixPasswordInvisibleWidget;
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  final String? errorThisFieldRequired;
  final String? errorInvalidEmail;
  final String? errorMinimumPasswordLength;
  final String? errorInvalidURL;
  final String? errorInvalidUsername;

  final String? title;
  final TextStyle? titleTextStyle;
  final int spacingBetweenTitleAndTextFormField;

  //ChatGPT Params
  // final bool enableChatGPT;
  // final Widget? suffixChatGPTIcon;
  // final Widget? loaderWidgetForChatGPT;
  // final InputDecoration? promptFieldInputDecorationChatGPT;
  // final bool shortReplyChatGPT;
  // final bool testWithoutKeyChatGPT;

  @Deprecated('Use TextFieldType.PASSWORD instead')
  final bool? isPassword;
  final bool obscureText;

  const AppTextField({
    this.controller,
    required this.textFieldType,
    this.decoration,
    this.focus,
    this.validator,
    this.isPassword,
    this.buildCounter,
    this.isValidationRequired = true,
    this.textCapitalization,
    this.textInputAction,
    this.onFieldSubmitted,
    this.nextFocus,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.onChanged,
    this.cursorColor,
    this.suffix,
    this.suffixIconColor,
    this.enableSuggestions,
    this.autoFocus = false,
    this.readOnly = false,
    this.maxLength,
    this.keyboardType,
    this.autoFillHints,
    this.scrollPadding,
    this.onTap,
    this.cursorWidth,
    this.cursorHeight,
    this.inputFormatters,
    this.errorThisFieldRequired,
    this.errorInvalidEmail,
    this.errorMinimumPasswordLength,
    this.errorInvalidURL,
    this.errorInvalidUsername,
    this.textAlignVertical,
    this.expands = false,
    this.showCursor,
    this.selectionControls,
    this.strutStyle,
    this.obscuringCharacter = '•',
    this.initialValue,
    this.keyboardAppearance,
    this.suffixPasswordVisibleWidget,
    this.suffixPasswordInvisibleWidget,
    this.contextMenuBuilder,
    this.title,
    this.titleTextStyle,
    this.spacingBetweenTitleAndTextFormField = 4,

    //ChatGpt Params
    // this.enableChatGPT = false,
    // this.loaderWidgetForChatGPT,
    // this.suffixChatGPTIcon,
    // this.promptFieldInputDecorationChatGPT,
    // this.shortReplyChatGPT = false,
    // this.testWithoutKeyChatGPT = false,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  bool isPasswordVisible = false;
  List<String> recentChat = [];

  FormFieldValidator<String>? applyValidation() {
    if (widget.isValidationRequired) {
      if (widget.validator != null) {
        return widget.validator;
      } else if (widget.textFieldType == TextFieldType.email) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired
                .validate(ConstantsString.errorThisFieldRequired);
          }
          if (!s.trim().isValidateEmail()) {
            return widget.errorInvalidEmail.validate('Email is invalid');
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.emailEnhanced) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired
                .validate(ConstantsString.errorThisFieldRequired);
          }
          if (!s.trim().validateEmailEnhanced()) {
            return widget.errorInvalidEmail.validate('Email is invalid');
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.password) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired
                .validate(ConstantsString.errorThisFieldRequired);
          }
          if (s.trim().length < ConstantsString.passwordLengthGlobal) {
            return widget.errorMinimumPasswordLength.validate(
                'Minimum password length should be ${ConstantsString.passwordLengthGlobal}');
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.name ||
          widget.textFieldType == TextFieldType.phone ||
          widget.textFieldType == TextFieldType.number) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired
                .validate(ConstantsString.errorThisFieldRequired);
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.url) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired
                .validate(ConstantsString.errorThisFieldRequired);
          }
          if (!s.validateURL()) {
            return widget.errorInvalidURL.validate('Invalid URL');
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.userName) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired
                .validate(ConstantsString.errorThisFieldRequired);
          }
          if (s.contains(' ')) {
            return widget.errorInvalidUsername
                .validate('Username should not contain space');
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.multiline) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired
                .validate(ConstantsString.errorThisFieldRequired);
          }
          return null;
        };
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  TextCapitalization applyTextCapitalization() {
    if (widget.textCapitalization != null) {
      return widget.textCapitalization!;
    } else if (widget.textFieldType == TextFieldType.name) {
      return TextCapitalization.words;
    } else if (widget.textFieldType == TextFieldType.multiline) {
      return TextCapitalization.sentences;
    } else {
      return TextCapitalization.none;
    }
  }

  TextInputAction? applyTextInputAction() {
    if (widget.textInputAction != null) {
      return widget.textInputAction;
    } else if (widget.textFieldType == TextFieldType.multiline) {
      return TextInputAction.newline;
    } else if (widget.nextFocus != null) {
      return TextInputAction.next;
    } else {
      return TextInputAction.done;
    }
  }

  TextInputType? applyTextInputType() {
    if (widget.keyboardType != null) {
      return widget.keyboardType;
    } else if (widget.textFieldType == TextFieldType.email ||
        widget.textFieldType == TextFieldType.emailEnhanced) {
      return TextInputType.emailAddress;
    } else if (widget.textFieldType == TextFieldType.multiline) {
      return TextInputType.multiline;
    } else if (widget.textFieldType == TextFieldType.password) {
      return TextInputType.visiblePassword;
    } else if (widget.textFieldType == TextFieldType.phone ||
        widget.textFieldType == TextFieldType.number) {
      return TextInputType.number;
    } else if (widget.textFieldType == TextFieldType.url) {
      return TextInputType.url;
    } else {
      return TextInputType.text;
    }
  }

  void onPasswordVisibilityChange(bool val) {
    isPasswordVisible = val;
    setState(() {});
  }

  Widget? suffixIcon() {
    if (widget.textFieldType == TextFieldType.password) {
      if (widget.suffix != null) {
        return widget.suffix;
      } else {
        if (isPasswordVisible) {
          if (widget.suffixPasswordVisibleWidget != null) {
            return widget.suffixPasswordVisibleWidget!.onTap(() {
              onPasswordVisibilityChange(false);
            });
          } else {
            return Icon(
              Icons.visibility,
              color:
                  widget.suffixIconColor ?? Theme.of(context).iconTheme.color,
            ).onTap(() {
              onPasswordVisibilityChange(false);
            });
          }
        } else {
          if (widget.suffixPasswordInvisibleWidget != null) {
            return widget.suffixPasswordInvisibleWidget!.onTap(() {
              onPasswordVisibilityChange(true);
            });
          } else {
            return Icon(
              Icons.visibility_off,
              color:
                  widget.suffixIconColor ?? Theme.of(context).iconTheme.color,
            ).onTap(() {
              onPasswordVisibilityChange(true);
            });
          }
        }
      }
    } else {
      return widget.suffix;
    }
  }

  Iterable<String>? applyAutofillHints() {
    if (widget.textFieldType == TextFieldType.email ||
        widget.textFieldType == TextFieldType.emailEnhanced) {
      return [AutofillHints.email];
    } else if (widget.textFieldType == TextFieldType.password) {
      return [AutofillHints.password];
    }
    return null;
  }

  Widget textFormFieldWidget() {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.textFieldType == TextFieldType.password &&
          !isPasswordVisible &&
          widget.obscureText,
      validator: applyValidation(),
      textCapitalization: applyTextCapitalization(),
      textInputAction: applyTextInputAction(),
      onFieldSubmitted: (s) {
        if (widget.nextFocus != null) {
          FocusScope.of(context).requestFocus(widget.nextFocus);
        }

        if (widget.onFieldSubmitted != null) widget.onFieldSubmitted!.call(s);
      },
      keyboardType: applyTextInputType(),
      decoration: widget.decoration != null
          ? (widget.decoration!.copyWith(
              suffixIcon: suffixIcon(),
            ))
          : const InputDecoration(),
      focusNode: widget.focus,
      style: widget.textStyle ?? primaryTextStyle(),
      textAlign: widget.textAlign,
      maxLines: widget.maxLines.validate( widget.textFieldType == TextFieldType.multiline ? 10 : 1),
      minLines: widget.minLines.validate( widget.textFieldType == TextFieldType.multiline ? 2 : 1),
      autofocus: widget.autoFocus,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      cursorColor: widget.cursorColor ??
          Theme.of(context).textSelectionTheme.cursorColor,
      readOnly: widget.readOnly,
      maxLength: widget.maxLength,
      enableSuggestions: widget.enableSuggestions.validate(value: true),
      autofillHints: widget.autoFillHints ?? applyAutofillHints(),
      scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20),
      cursorWidth: widget.cursorWidth.validate(value: 2.0),
      cursorHeight: widget.cursorHeight,
      cursorRadius: radiusCircular(4),
      onTap: widget.onTap,
      buildCounter: widget.buildCounter,
      scrollPhysics: const BouncingScrollPhysics(),
      enableInteractiveSelection: true,
      inputFormatters: widget.inputFormatters,
      textAlignVertical: widget.textAlignVertical,
      expands: widget.expands,
      showCursor: widget.showCursor,
      selectionControls:
          widget.selectionControls ?? MaterialTextSelectionControls(),
      strutStyle: widget.strutStyle,
      obscuringCharacter: widget.obscuringCharacter,
      initialValue: widget.initialValue,
      keyboardAppearance: widget.keyboardAppearance,
      contextMenuBuilder: widget.contextMenuBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.title.validate().isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title!,
            style: widget.titleTextStyle ?? primaryTextStyle(),
          ),
          widget.spacingBetweenTitleAndTextFormField.height(),
          textFormFieldWidget(),
        ],
      );
    }

    return textFormFieldWidget();
  }
}
