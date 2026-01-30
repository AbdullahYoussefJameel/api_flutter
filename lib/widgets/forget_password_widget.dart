import 'package:flutter/material.dart';

class ForgetPasswordWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const ForgetPasswordWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.8,
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero, // إزالة padding افتراضي
          minimumSize: const Size(0, 0), // تصغير المساحة
          tapTargetSize:
              MaterialTapTargetSize.shrinkWrap, // لتقليل المساحة الفارغة
        ),
        child: const Text(
          'Forget password?',
          style: TextStyle(
            color: Color(0xff939393),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
