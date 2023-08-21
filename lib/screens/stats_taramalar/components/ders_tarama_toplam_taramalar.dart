import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class DersTaramaToplamTaramalarWidget extends StatefulWidget {
  final String title;
  final Map<String, dynamic> data;
  const DersTaramaToplamTaramalarWidget({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  State<DersTaramaToplamTaramalarWidget> createState() =>
      _DersTaramaToplamTaramalarWidgetState();
}

class _DersTaramaToplamTaramalarWidgetState
    extends State<DersTaramaToplamTaramalarWidget> {
  late List<MapEntry> myData;

  @override
  void initState() {
    setState(() {
      myData = widget.data.entries.toList();
      myData.sort((a, b) => b.value.compareTo(a.value));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: defaultPadding,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: defaultPadding,
            childAspectRatio: 1.5,
            shrinkWrap: true,
            children: [
              ...myData.map(
                (e) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(164, 20, 20, 20),
                      borderRadius: BorderRadius.circular(defaultPadding),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.key,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        Text(
                          e.value.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: const Color.fromARGB(255, 189, 236, 238),
                                fontSize: 21,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
