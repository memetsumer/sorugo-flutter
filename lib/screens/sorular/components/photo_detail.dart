import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class PhotoDetail extends StatelessWidget {
  final String url;
  const PhotoDetail({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0.3),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              )),
        ),
        body: Center(
          child: PinchZoom(
            resetDuration: const Duration(milliseconds: 100),
            child: CachedNetworkImage(imageUrl: url),
          ),
        ));
  }
}
