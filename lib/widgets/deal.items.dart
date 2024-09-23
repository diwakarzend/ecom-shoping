/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class DealItems extends StatelessWidget {
  final bool gridView;
  final AppProvider provider;
  final CartHelper cartHelper;
  final Product product;
  final Function() onProductClick;
  final Function() onAddToCart;

  const DealItems({
    super.key,
    required this.product,
    required this.onProductClick,
    required this.onAddToCart,
    required this.provider,
    required this.cartHelper,
    required this.gridView,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () => onProductClick(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(right: gridView ? 0 : 10),
        decoration: BoxDecoration(
          color: ColorConstants.colorDeal,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: CustomNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: IconButton(
                      iconSize: 25,
                      onPressed: () async {
                        cartHelper.addToWishList(provider: provider, context: context, productId: product.id);
                      },
                      icon: provider.wishlist != null && provider.wishlist!.records.any((element) => element.productId == product.id)
                          ? const Icon(
                              Ionicons.heart,
                              color: Colors.red,
                            )
                          : Icon(
                              Ionicons.heart_outline,
                              color: ColorConstants.colorBlackTwo.withOpacity(0.5),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand?.name ?? '',
                    style: TextHelper.smallTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.name,
                    style: TextHelper.smallTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.colorBlackFour,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        'Worth',
                        style: TextHelper.extraSmallTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Rs.${product.mrp}',
                        style: TextHelper.extraSmallTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Rs.${product.salePrice}',
                        style: TextHelper.extraSmallTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () => _showDownloadDialog(context),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConstants.colorPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      alignment: Alignment.center,
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ]),
            )])));
  }

  void _showDownloadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Download APK'),
          content: Text('This Feature is only available on your APP?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _downloadAPK();
              },
              child: Text('Download'),
            ),
          ],
        );
      },
    );
  }

  void _downloadAPK() async {
    const launchUri = 'https://shoppingapps.s3.ap-south-1.amazonaws.com/Artimbe1-release.apk';
    if (await canLaunch(launchUri)) {
      await launch(launchUri);
    } else {
      print('Could not launch $launchUri');
    }
  }
}

//
// void _downloadAPK() async {
//   const launchUri = 'https://shoppingapps.s3.ap-south-1.amazonaws.com/Artimbe1-release.apk';
//   await launchUrl(Uri.parse(launchUri));
// }
