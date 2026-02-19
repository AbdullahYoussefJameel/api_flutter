import 'package:flutter/material.dart';

class PageHeading extends StatelessWidget {
  final String title;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  /// PageHeading widget مع دعم الثيم والدعم المرن للحجم والهوامش
  const PageHeading({
    Key? key,
    required this.title,
    this.fontSize = 30,
    this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // اختيار لون الخط بناءً على الثيم الحالي
    final isDark = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;

    return Container(
      alignment: Alignment.centerLeft,
      padding: padding,
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'NotoSerif',
          color: isDark,
        ),
      ),
    );
  }
}
