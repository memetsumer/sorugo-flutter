import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/denemeler/deneme_manager.dart';
import '../../utils/constants.dart';

class SorugoSubmitForm extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final int? maxLength;
  final bool error;

  const SorugoSubmitForm({
    Key? key,
    this.labelText,
    this.hintText,
    this.maxLength,
    required this.error,
  }) : super(key: key);

  @override
  State<SorugoSubmitForm> createState() => _SorugoSubmitFormState();
}

class _SorugoSubmitFormState extends State<SorugoSubmitForm> {
  final _descriptionController = TextEditingController();

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    _descriptionController.addListener(() {
      setState(() {
        context
            .read<DenemeManager>()
            .setDenemeTitle(_descriptionController.text.trim());
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();

    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          border: Border.all(
              width: !widget.error ? 0 : 1,
              color: !widget.error ? Colors.transparent : Colors.redAccent),
          color: darkBackgroundColorSecondary,
          borderRadius: BorderRadius.circular(defaultPadding / 2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Form(
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyMedium,
            keyboardType: TextInputType.multiline,
            focusNode: focusNode,
            textInputAction: TextInputAction.done,
            maxLength: widget.maxLength,
            controller: _descriptionController,
            decoration: InputDecoration(
                counterText: "",
                labelText: widget.labelText,
                hintText: widget.hintText,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
