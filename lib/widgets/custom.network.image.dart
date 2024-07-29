/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatefulWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.height,
    this.width,
  });

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => loadImage());
    super.initState();
  }

  Future loadImage() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    await Future.wait([cacheImage()]);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future cacheImage() async {
    if (kDebugMode) {
      await precacheImage(
          CachedNetworkImageProvider(
              widget.imageUrl.replaceAll('https://d3r50zdh245qd1.cloudfront.net/', 'https://fabpiks-media.s3.ap-south-1.amazonaws.com/')),
          context);
    } else {
      await precacheImage(CachedNetworkImageProvider(widget.imageUrl), context);
    }
  }

  @override
  void dispose() {
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            width: widget.width,
            height: widget.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : CachedNetworkImage(
            imageUrl: kDebugMode
                ? widget.imageUrl.replaceAll('https://d3r50zdh245qd1.cloudfront.net/', 'https://fabpiks-media.s3.ap-south-1.amazonaws.com/')
                : widget.imageUrl,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            useOldImageOnUrlChange: true,
            errorWidget: (c, s, _) {
              return SizedBox(
                width: widget.width,
                height: widget.height,
              );
            },
          );
  }
}
