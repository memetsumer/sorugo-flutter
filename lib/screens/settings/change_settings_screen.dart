import 'package:flutter/material.dart';
import 'package:flutter_yks_app/utils/constants.dart';

class ChangeSettingsScreen extends StatelessWidget {
  final Widget child;
  const ChangeSettingsScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgPath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              width: size.width * 0.8,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black.withOpacity(0.1),
                border: Border.all(
                  color: Colors.white24,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [child],
              ),
            ),
          ),
        ));
  }
}
