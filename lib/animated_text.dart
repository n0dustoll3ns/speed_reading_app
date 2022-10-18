import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  final AnimationController controller;
  final String text;
  final Animation<double> fontSize;
  final Animation<double> opacity;
  AnimatedText({Key? key, required this.controller, required this.text})
      : fontSize = Tween<double>(
          begin: 25,
          end: 45,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 1, curve: Curves.easeOutQuad),
          ),
        ),
        opacity = Tween<double>(
          begin: 0.8,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 1, curve: Curves.easeInQuart),
          ),
        ),
        super(key: key);

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize.value, color: Colors.black.withOpacity(opacity.value)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
