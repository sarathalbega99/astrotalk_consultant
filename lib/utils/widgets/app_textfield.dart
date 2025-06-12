import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/all_const.dart';

class AppTextField extends StatelessWidget {
  final String? hint;
  final String? initValue;
  final bool? isReadyOnly;
  final TextEditingController? controller;
  final TextInputType? keyboardInputType;
  final List<TextInputFormatter>? formatter;
  final Function()? onTaps;
  final String? Function(String?)? validate;
  final String? Function(String?)? onchange;
  final String? Function(String?)? onField;
  final Function(PointerDownEvent?)? onOutSideTap;
  final int? maxLength;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final int? maxLine;
  final bool? obscureText;
  final TextInputAction? txtInputAction;
  final Widget? suffixIcon;
  final TextCapitalization? textCapitalization;
  final bool? showSuggesedMenu;
  final bool? showToolbar;
  final bool? autoFocus;
  final AutovalidateMode? autovalidateModee;
  final Widget? labelText;
  final EdgeInsetsGeometry? contentPadding;
  final Color? enabledBorderColor;
  final Color? focusBorderColor;
  final Color? errordBorderColor;
  final Color? hintTextColor;
  final Color? errordTextColor;
  final Color? fillColor;
  final double? borderRadius;
  final Color? textColor;
  final bool? enableInteractiveSelection;

  const AppTextField({
    super.key,
    this.hint,
    this.isReadyOnly,
    this.controller,
    this.keyboardInputType,
    this.formatter,
    this.onTaps,
    this.validate,
    this.onchange,
    this.maxLength,
    this.focusNode,
    this.onField,
    this.prefix,
    this.suffix,
    this.obscureText,
    this.txtInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLine,
    this.textCapitalization,
    this.showSuggesedMenu,
    this.showToolbar,
    this.onOutSideTap,
    this.autovalidateModee,
    this.autoFocus,
    this.labelText,
    this.contentPadding,
    this.initValue,
    this.enabledBorderColor,
    this.errordBorderColor,
    this.focusBorderColor,
    this.hintTextColor,
    this.errordTextColor,
    this.fillColor,
    this.borderRadius,
    this.textColor,
    this.enableInteractiveSelection,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: enableInteractiveSelection,
      smartDashesType:
          showSuggesedMenu == false ? SmartDashesType.disabled : null,
      // contextMenuBuilder: (context, editableTextState) {

      // },
      // ignore: deprecated_member_use
      toolbarOptions:
          showToolbar == false
              // ignore: deprecated_member_use
              ? const ToolbarOptions(
                copy: false,
                paste: false,
                selectAll: false,
                cut: false,
              )
              : null,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      autofocus: autoFocus ?? false,
      autovalidateMode: autovalidateModee ?? AutovalidateMode.onUserInteraction,
      maxLines: maxLine ?? 1,
      initialValue: initValue,
      onChanged: onchange ?? (val) {},

      autocorrect: false,
      validator:
          validate ??
          (value) {
            return null;
          },
      onTapOutside: onOutSideTap ?? (event) {},
      scrollPadding: const EdgeInsets.only(bottom: 16.0),
      onTap: onTaps,
      style: TextStyle(
        fontSize: AppFontSizes.defaultSize(context),
        // fontFamily: 'Overpass',
        color: textColor ?? AppColors.textPrimary,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,

        decorationThickness: 0,
      ),
      controller: controller,
      focusNode: focusNode,
      readOnly: isReadyOnly ?? false,
      obscureText: obscureText ?? false,
      keyboardType: keyboardInputType ?? TextInputType.text,
      maxLength: maxLength,
      inputFormatters: formatter ?? [],
      onFieldSubmitted: onField,
      textInputAction: txtInputAction ?? TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        label: labelText,
        // errorText: "WRONG DA dey wrong ",
        filled: true,
        fillColor:
            // isReadyOnly == true
            // ? Colors.grey.shade200 :
            fillColor ?? Colors.transparent,
        prefix: prefix,
        counter: const SizedBox(),
        hintText: hint ?? '',
        suffix: suffix,
        suffixIcon: suffixIcon,
        errorStyle: TextStyle(
          fontSize: AppFontSizes.defaultSize(context),
          color: errordTextColor ?? Colors.red.shade300,
        ),
        hintStyle: TextStyle(
          color: hintTextColor ?? AppColors.hintText,
          fontSize: AppFontSizes.defaultSize(context),
          fontWeight: FontWeight.w500,
        ),
        contentPadding: contentPadding ?? const EdgeInsets.all(16.0),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: errordBorderColor ?? Colors.red.shade300,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: enabledBorderColor ?? AppColors.border,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: errordBorderColor ?? Colors.red.shade300,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: focusBorderColor ?? AppColors.textPrimary,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
      ),
    );
  }
}
