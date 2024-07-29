/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

@RoutePage(name: 'ImageGalleryRoute')
class ImageGallery extends StatefulWidget {
  final List<String> images;
  final int index;

  const ImageGallery({super.key, required this.images, required this.index});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  late PageController controller;
  int activeIndex = 0;

  @override
  void initState() {
    controller = PageController(initialPage: widget.index);
    activeIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.colorOffWhite,
        elevation: 0,
      ),
      backgroundColor: ColorConstants.colorOffWhite,
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(widget.images[index], cacheKey: widget.images[index]),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes: PhotoViewHeroAttributes(tag: widget.images[index]),
          );
        },
        allowImplicitScrolling: true,
        itemCount: widget.images.length,
        loadingBuilder: (context, event) => Center(
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              color: ColorConstants.colorPrimary,
              value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            ),
          ),
        ),
        backgroundDecoration: const BoxDecoration(
          color: ColorConstants.colorOffWhite,
        ),
        pageController: controller,
        onPageChanged: (i) {
          setState(() {
            activeIndex = i;
          });
        },
      ),
      bottomNavigationBar: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.of(context).padding.bottom + 20),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...widget.images
                .asMap()
                .map(
                  (i, img) => MapEntry(
                    i,
                    InkWell(
                      onTap: () => controller.animateToPage(i, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
                      child: Container(
                        width: height * .1,
                        height: height * .1,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: activeIndex == i ? ColorConstants.colorBlack : Colors.transparent,
                            width: 1,
                          ),
                          // image: DecorationImage(
                          //   image: CachedNetworkImageProvider(img, cacheKey: img),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        child: CustomNetworkImage(
                          imageUrl: img,
                          width: height * .1,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
                .values,
          ],
        ),
      ),
    );
  }
}
