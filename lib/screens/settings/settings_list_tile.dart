import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final FaIcon? faIcon;
  final Icon? icon;
  final Widget? trailing;

  // final
  const SettingsListTile({
    Key? key,
    required this.onTap,
    required this.title,
    this.faIcon,
    this.icon,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Colors.white24,
          width: 0.6,
        ),
      ),
      dense: true,
      onTap: onTap,
      leading: icon ?? faIcon,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white),
      ),
      trailing: trailing,
    );
  }
}
