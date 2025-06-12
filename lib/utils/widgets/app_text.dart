import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final int? maxLine;
  final FontStyle? font;
  final TextStyle? style;
  final dynamic isTitle;
  final List<FontFeature>? fontFeatures;

  const AppText(
      {super.key,
        required this.text,
        this.color,
        required this.size,
        this.weight,
        this.textAlign,
        this.maxLine,
        this.font,
        this.style, this.isTitle,this.fontFeatures});

  @override
  Widget build(BuildContext context) {
    return isTitle == null ? Text(
      text ?? '',
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine ?? 2,
      style: style ??
          TextStyle(
            color: color ?? Colors.black,
            fontSize: size,
            fontWeight: weight ?? FontWeight.normal,
            fontFeatures: fontFeatures ?? const []
          ),
      textAlign: textAlign ?? TextAlign.start,
    ) : Text(
      text ?? '',
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine ?? 2,
      style: GoogleFonts.inter(
        color: color ?? Colors.black,
        fontSize: size,
        fontWeight: weight ?? FontWeight.normal,
        fontFeatures: fontFeatures ?? const []
      ),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}