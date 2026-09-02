import 'package:flutter/material.dart';

class AfanGradientText extends StatelessWidget {
  final String text;
  final bool darkRequired;
  final TextStyle? style;
  final TextAlign? textAlign;

  const AfanGradientText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.darkRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    // 🌙 DARK MODE → WHITE TEXT
    if (isDarkMode && darkRequired == true) {
      return Text(
        text,
        textAlign: textAlign,
        style: style?.copyWith(
          color: Colors.white,
        ),
      );
    }

    // ☀️ LIGHT MODE → GRADIENT TEXT
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            Color(0xFF263B73),
            Color(0xFFA1ADDB),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Text(
        text,
        textAlign: textAlign,
        style: style?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}