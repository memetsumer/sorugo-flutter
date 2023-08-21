import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class GlassmorphicCategoryWidget extends StatelessWidget {
  final Widget child;
  final bool isSelected;
  const GlassmorphicCategoryWidget({
    Key? key,
    required this.child,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      constraints: BoxConstraints(
        minWidth: size.width * 0.2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding),
        gradient: isSelected
            ? const LinearGradient(colors: [
                Color.fromARGB(255, 78, 36, 85),
                Color.fromARGB(255, 66, 2, 53),
              ])
            : LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.1),
                  ]),
        border: Border.all(
          color: Colors.white24,
          width: 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: darkGradientPurple.withOpacity(0.8),
                  blurRadius: 15,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.8),
                  blurRadius: 15,
                ),
              ],
      ),
      child: child,
    );
  }
}
