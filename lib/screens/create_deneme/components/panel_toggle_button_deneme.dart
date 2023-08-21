import 'package:flutter/material.dart';
import '../../components/sorugo_button.dart';
import '/models/denemeler/deneme_manager.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';

class PanelToggleButtonDeneme extends StatefulWidget {
  final String btnText;
  final Function openDialog;
  final bool error;

  const PanelToggleButtonDeneme({
    required this.btnText,
    required this.openDialog,
    required this.error,
    Key? key,
  }) : super(key: key);

  @override
  State<PanelToggleButtonDeneme> createState() =>
      _PanelToggleButtonDenemeState();
}

class _PanelToggleButtonDenemeState extends State<PanelToggleButtonDeneme> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SorugoButton(
          onPress: () {
            widget.openDialog();
          },
          text: "Seç",
        ),
        const SizedBox(
          width: defaultPadding * 2,
        ),
        Expanded(
            child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            color: darkBackgroundColorSecondary,
            border: Border.all(
              color: !widget.error
                  ? darkBackgroundColorSecondary
                  : Colors.redAccent,
              width: !widget.error ? 0 : 1,
            ),
            borderRadius: BorderRadius.circular(defaultPadding / 2),
          ),
          child: Text(
            context.watch<DenemeManager>().getDeneme == null
                ? "Deneme Türü..."
                : context.watch<DenemeManager>().getDeneme!.name,
            textAlign: TextAlign.center,
          ),
        ))
      ],
    );
  }
}
