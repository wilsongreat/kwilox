import 'package:brayon_news_network_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final Function()? onTap;
  final int? maxLines;
  final double? fontSize;
  final TextStyle? textStyle;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;

  TextView({
    required this.text,
    this.textOverflow = TextOverflow.clip,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.textStyle,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
                fontFamily: fontFamily ?? 'Poppins',
                fontSize: fontSize,
                fontWeight: fontWeight ?? FontWeight.w400,
                color: color ?? BLACK),
        textAlign: textAlign,
        overflow: textOverflow,
        maxLines: maxLines,
      ),
    );
  }
}
