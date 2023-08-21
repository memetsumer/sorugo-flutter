import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class DropdownMenuNetler extends StatelessWidget {
  final Map<String, dynamic> categories;
  final String selectedItem;
  final Function(String) onChanged;
  const DropdownMenuNetler({
    Key? key,
    required this.categories,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 170,
      ),
      child: DropdownButtonFormField(
        focusColor: Colors.transparent,
        icon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
          ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        dropdownColor: const Color(0xff181818),
        value: selectedItem,
        borderRadius: BorderRadius.circular(defaultPadding),
        items: [
          DropdownMenuItem(
            value: "-",
            child: Text(
              "Filtrele",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          ...categories.entries.map(
            (e) {
              String value =
                  "${e.value['dersName']} ${e.value['ayt'] ? 'AYT' : 'TYT'}";
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              );
            },
          ).toList(),
        ],
        onChanged: (value) {
          onChanged(
            value! as String,
          );
        },
      ),
    );
  }
}
