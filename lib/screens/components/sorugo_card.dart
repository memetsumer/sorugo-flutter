import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class SorugoCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final Alignment? begin;
  final Alignment? end;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final double? opacityBackground, opacityForeground;
  final double? elevation, cardMargin;
  final Color? backgroundColor;
  final List<Color>? gradientColors;
  final double? borderRadius;
  final Color? borderColor;

  const SorugoCard({
    Key? key,
    required this.child,
    this.width,
    this.begin,
    this.end,
    this.padding,
    this.constraints,
    this.opacityBackground,
    this.opacityForeground,
    this.elevation,
    this.cardMargin,
    this.backgroundColor,
    this.gradientColors,
    this.borderRadius,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 20,
      margin: EdgeInsets.symmetric(horizontal: cardMargin ?? 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? defaultPadding),
      ),
      shadowColor: darkGradientPurple.withOpacity(0.9),
      color:
          backgroundColor ?? Colors.amber.withOpacity(opacityBackground ?? 0.1),
      child: Container(
        width: width,
        constraints: constraints,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? defaultPadding),
          gradient: LinearGradient(
            colors: gradientColors ??
                const [
                  Color.fromARGB(255, 78, 36, 85),
                  Color.fromARGB(255, 66, 2, 53),
                ],
            begin: begin ?? Alignment.centerLeft,
            end: end ?? Alignment.centerRight,
          ),
          border: Border.all(
            color: borderColor ?? Colors.white24,
            width: 0.7,
          ),
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}
