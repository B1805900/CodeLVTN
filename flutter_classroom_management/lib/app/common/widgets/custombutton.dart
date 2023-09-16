import 'package:flutter/material.dart';
import 'package:flutter_classroom_management/app/common/constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.text,
    this.borderRadius,
    this.backgroundColor,
    this.fontSize,
    this.foregroundColor,
  }) : super(key: key);

  final String text;
  final double height, width;
  final GestureTapCallback onPressed;
  final double? borderRadius, fontSize;
  final Color? backgroundColor, foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(backgroundColor ?? primaryColor),
          foregroundColor:
              MaterialStateProperty.all<Color>(foregroundColor ?? Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 30),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
