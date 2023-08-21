import 'package:flutter/material.dart';
import '/screens/components/sorugo_button.dart';
import 'package:provider/provider.dart';

import '../../../models/sorular/soru_manager.dart';
import '../../../utils/constants.dart';

class PanelToggleButtonDers extends StatelessWidget {
  final String btnText;
  final String type;
  final Function openDialog;
  final bool error;

  const PanelToggleButtonDers({
    required this.btnText,
    required this.type,
    required this.openDialog,
    required this.error,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SorugoButton(
          onPress: () {
            openDialog();
          },
          text: "Ders Seç",
          width: 100,
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
                color: !error ? darkBackgroundColorSecondary : Colors.redAccent,
                width: !error ? 0 : 1,
              ),
              borderRadius: BorderRadius.circular(defaultPadding / 2),
            ),
            child: Text(
              context.watch<SoruManager>().selectedDers == null
                  ? 'Ders...'
                  : context.watch<SoruManager>().selectedDers!.name,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}

class PanelToggleButtonKonu extends StatelessWidget {
  final String btnText;
  final String type;
  final Function openDialog;
  final bool error;

  const PanelToggleButtonKonu({
    required this.btnText,
    required this.type,
    required this.openDialog,
    required this.error,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SorugoButton(
          onPress: () {
            openDialog();
          },
          width: 100,
          text: "Konu Seç",
        ),
        const SizedBox(
          width: defaultPadding * 2,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding / 2),
            decoration: BoxDecoration(
              border: Border.all(
                color: !error ? darkBackgroundColorSecondary : Colors.redAccent,
                width: !error ? 0 : 1,
              ),
              color: darkBackgroundColorSecondary,
              borderRadius: BorderRadius.circular(defaultPadding / 2),
            ),
            child: Text(
              context.watch<SoruManager>().selectedKonu == ''
                  ? 'Konu...'
                  : context.watch<SoruManager>().selectedKonu,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
