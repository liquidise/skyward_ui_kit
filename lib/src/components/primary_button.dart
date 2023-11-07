import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  Image? buttonIcon;
  final Function onPressed;
  final LinearGradient? gradient;
  final bool disabled;

  PrimaryButton( {
    required this.buttonText,
    required this.onPressed,
    this.disabled = false,
    this.buttonIcon,
    this.gradient = const LinearGradient(
      colors: [
        Color(0xffF08B60),
        Color(0xffEF8764),
        Color(0xffE45F9F),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    super.key,
  });

  Color toGrey( Color originalColor ) {
    // Formula to convert a color to grayscale (luma): 0.2126 * R + 0.7152 * G + 0.0722 * B
    final double grayscaleValue =
      0.2126 * originalColor.red +
      0.7152 * originalColor.green +
      0.0722 * originalColor.blue;

    // Return the grayscale color
    return Color.fromRGBO(
      grayscaleValue.toInt(),
      grayscaleValue.toInt(),
      grayscaleValue.toInt(),
      originalColor.opacity
    );
  }

  @override
  Widget build(BuildContext context) {
    Gradient? buttonGradient = this.gradient;
    if( this.disabled && this.gradient is LinearGradient ) {
      buttonGradient = LinearGradient(
        colors: this.gradient!.colors.map( (color) => toGrey(color) ).toList(),
        begin: this.gradient!.begin,
        end: this.gradient!.end,
        tileMode: this.gradient!.tileMode,
      );
    }

    return InkWell(
      splashColor: const Color(0xff6A0136).withOpacity(0.9),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 160),
        child: Container(
          decoration: BoxDecoration(
            gradient: buttonGradient,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (buttonIcon != null) ...[
                Image.asset(
                  "assets/images/whiteGauge.png",
                  width: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
              Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Value',
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if( this.disabled ) {
          return;
        }

        HapticFeedback.selectionClick();
        this.onPressed();
      },
    );
  }
}
