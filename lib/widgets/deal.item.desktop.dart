/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:ionicons/ionicons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DealItemDesktop extends StatelessWidget {
  final bool gridView;
  final AppProvider provider;
  final CartHelper cartHelper;
  final Product product;
  final Function() onProductClick;
  final Function() onAddToCart;
  final String sub_category;

  const DealItemDesktop({
    super.key,
    required this.product,
    required this.onProductClick,
    required this.onAddToCart,
    required this.provider,
    required this.cartHelper,
    required this.gridView,
    required this.sub_category,

  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => onProductClick(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(right: gridView ? 0 : 10),
        decoration: BoxDecoration(
          // color: ColorConstants.colorDeal,
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
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
                      icon: provider.wishlist != null && provider.wishlist!.records.any((element) => element.id == product.id)
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
                    style: TextHelper.normalTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.name,
                    style: TextHelper.normalTextStyle.copyWith(
                      fontSize: 12.sp,
                      color: ColorConstants.colorBlackFour,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        'Worth',
                        style: TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Rs.${product.mrp}',
                        style: TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12.sp,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Rs.${product.salePrice}',
                        style: TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Alert'),
                          content: const Text('This feature is only available on our app.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => _downloadAPK(),
                              child: const Text('Download APK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * .06,
                      width: width * .17,
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: width * .01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff033F5C),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _downloadAPK() async {
  const launchUri = 'https://shoppingapps.s3.ap-south-1.amazonaws.com/Artimbe1-release.apk';
  await launchUrl(Uri.parse(launchUri));
}
