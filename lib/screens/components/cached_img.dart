import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '/utils/constants.dart';

class CachedImg extends StatelessWidget {
  final String imgUrl;
  const CachedImg({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fadeInDuration: const Duration(milliseconds: 200),
      placeholderFadeInDuration: const Duration(milliseconds: 200),
      imageUrl: imgUrl,
      width: double.infinity,
      height: double.infinity,
      maxHeightDiskCache: 900,
      placeholder: (context, url) => Shimmer.fromColors(
          baseColor: darkBackgroundColorSecondary,
          highlightColor: Colors.purpleAccent,
          child: Container(
            color: Colors.grey.shade300,
          )),
      errorWidget: (context, url, error) => Shimmer.fromColors(
          baseColor: darkBackgroundColorSecondary,
          highlightColor: Colors.redAccent,
          child: Container(
            color: Colors.grey.shade300,
          )),
      fit: BoxFit.cover,
    );
  }
}

class CachedImgLower extends StatelessWidget {
  final String imgUrl;
  const CachedImgLower({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fadeInDuration: const Duration(milliseconds: 200),
      placeholderFadeInDuration: const Duration(milliseconds: 200),
      imageUrl: imgUrl,
      width: double.infinity,
      height: double.infinity,
      maxHeightDiskCache: 300,
      placeholder: (context, url) => Shimmer.fromColors(
          baseColor: darkBackgroundColorSecondary,
          highlightColor: Colors.purpleAccent,
          child: Container(
            color: Colors.grey.shade300,
          )),
      errorWidget: (context, url, error) => Shimmer.fromColors(
          baseColor: darkBackgroundColorSecondary,
          highlightColor: Colors.redAccent,
          child: Container(
            color: Colors.grey.shade300,
          )),
      fit: BoxFit.cover,
    );
  }
}
