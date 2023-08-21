import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import '/screens/denemeler/components/denemeler_list.dart';

import '../create_deneme/components/dialog_deneme_turu.dart';
import '/utils/constants.dart';

class DenemelerScreen extends StatefulWidget {
  const DenemelerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DenemelerScreen> createState() => _DenemelerScreenState();
}

class _DenemelerScreenState extends State<DenemelerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text("Denemelerin",
              style: Theme.of(context).textTheme.titleLarge),
          centerTitle: false,
          backgroundColor: Colors.transparent),
      body: const DenemelerList(),
    );
  }

  Future openDialog(String typeOfPanel) => showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 300),
      ),
      context: context,
      builder: (context) => Builder(
            builder: (context) => AlertDialog(
              backgroundColor: darkBackgroundColorSecondary,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              content: Container(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                child: const DialogDenemeTurleri(),
              ),
            ),
          ));
}
