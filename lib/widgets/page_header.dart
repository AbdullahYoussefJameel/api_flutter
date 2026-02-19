import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String imagePath;
  final double heightFactor; // نسبة ارتفاع الصورة بالنسبة للشاشة

  const PageHeader({
    Key? key,
    this.imagePath = 'assets/images/friendship.png',
    this.heightFactor = 0.3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * heightFactor,
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}
