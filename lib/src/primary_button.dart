import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  Image? buttonIcon;
  final Function onPressed;
	final Gradient? gradient;

  PrimaryButton( {
    required this.buttonText,
    required this.onPressed,
    this.buttonIcon,
		this.gradient = LinearGradient(
      colors: [
        Color(0xffF08B60),
        Color(0xffEF8764),
        Color(0xffE45F9F),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    )
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color(0xff6A0136).withOpacity(0.9),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 160),
        child: Container(
          decoration: BoxDecoration(
            gradient: this.gradient,
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
        HapticFeedback.selectionClick();
        print("hello");
        onPressed();
      },
    );
  }
}
