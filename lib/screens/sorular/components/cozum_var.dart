import 'package:flutter/material.dart';

import '/screens/components/cached_img.dart';
import '/screens/sorular/components/photo_detail.dart';
import '../../../utils/constants.dart';

class Cozum extends StatefulWidget {
  final String data;
  final bool hasCozum;
  final CachedImg img;
  const Cozum({
    Key? key,
    required this.hasCozum,
    required this.data,
    required this.img,
  }) : super(key: key);

  @override
  State<Cozum> createState() => _CozumState();
}

class _CozumState extends State<Cozum> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: AspectRatio(
        aspectRatio: 0.75,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhotoDetail(url: widget.data)));
                },
                child: Stack(
                  children: [
                    widget.img,
                  ],
                ))),
      ),
    );
  }
}
