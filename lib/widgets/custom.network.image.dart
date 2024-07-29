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

  String replaceUrlOrigin(String url) {
    final oldOriginPattern = RegExp(r'^https://d3r50zdh245qd1\.cloudfront\.net/');
    const newOrigin = 'https://fabpiks-media.s3.ap-south-1.amazonaws.com/';

    return url.replaceFirst(oldOriginPattern, newOrigin);
  }

  Future cacheImage() async {
    final newImageUrl = replaceUrlOrigin(widget.imageUrl);

    if (kDebugMode) {
      await precacheImage(CachedNetworkImageProvider(newImageUrl), context);
    } else {
      await precacheImage(CachedNetworkImageProvider(newImageUrl), context);
    }
  }

  @override
  void dispose() {
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = replaceUrlOrigin(widget.imageUrl);

    return isLoading
        ? SizedBox(
            width: widget.width,
            height: widget.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : CachedNetworkImage(
            imageUrl: imageUrl,
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
