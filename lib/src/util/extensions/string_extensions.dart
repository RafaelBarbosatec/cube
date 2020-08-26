import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension StringExtensions on String {
  Text body(
    BuildContext context, {
    double fontSize,
    Color color,
    TextDecoration decoration,
    FontWeight fontWeight,
    double letterSpacing,
    double wordSpacing,
    TextAlign textAlign,
    int maxLines,
    TextOverflow overflow,
  }) {
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontSize: fontSize,
            color: color,
            decoration: decoration,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
          ),
    );
  }

  Text headline(
    BuildContext context, {
    double fontSize,
    Color color,
    TextDecoration decoration,
    FontWeight fontWeight,
    double letterSpacing,
    double wordSpacing,
    TextAlign textAlign,
    int maxLines,
    TextOverflow overflow,
  }) {
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: Theme.of(context).textTheme.headline5.copyWith(
            fontSize: fontSize,
            color: color,
            decoration: decoration,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
          ),
    );
  }

  Text title(
    BuildContext context, {
    double fontSize,
    Color color,
    TextDecoration decoration,
    FontWeight fontWeight,
    double letterSpacing,
    double wordSpacing,
    TextAlign textAlign,
    int maxLines,
    TextOverflow overflow,
  }) {
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: Theme.of(context).textTheme.headline6.copyWith(
            fontSize: fontSize,
            color: color,
            decoration: decoration,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
          ),
    );
  }
}
