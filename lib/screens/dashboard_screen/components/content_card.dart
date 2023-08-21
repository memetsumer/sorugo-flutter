import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ContentCard extends StatelessWidget {
  final String title;

  final VoidCallback onPressed;
  const ContentCard({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      constraints: BoxConstraints(
        minWidth: size.width * 0.2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding),
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.white.withOpacity(0.05),
              Colors.white.withOpacity(0.11),
            ]),
        border: Border.all(
          color: Colors.white24,
          width: 1,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: darkGradientPurple,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultPadding)),
        ),
        child: Container(
          constraints: BoxConstraints(
            minWidth: size.width * 0.2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultPadding),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 13,
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
