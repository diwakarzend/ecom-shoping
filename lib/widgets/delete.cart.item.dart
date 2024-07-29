/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DeleteCartItem extends StatelessWidget {
  final Function() remove;
  final Function() move;
  final CartItem product;

  const DeleteCartItem({
    super.key,
    required this.product,
    required this.remove,
    required this.move,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return (Device.width >= 1024)
        ? AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Container(
              width: width * .35,
              height: height * .367,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remove product from cart?',
                    style: (Device.width >= 1024) ? TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 13.sp) : TextHelper.subTitleStyle,
                  ),
                  SizedBox(height: height * .02),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: (Device.width >= 1024) ? (width * .05) : width * .3,
                        height: (Device.width >= 1024) ? width * .07 : width * .35,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: CustomNetworkImage(
                          imageUrl: product.image,
                          width: (Device.width >= 1024) ? (width * .05) : width * .3,
                          height: (Device.width >= 1024) ? width * .07 : width * .35,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'You can save this product to your wishlist instead, and find it with ease the next time you come back.',
                            maxLines: 1000,
                            style: (Device.width >= 1024) ? TextHelper.smallTextStyle.copyWith(fontSize: 13.sp) : TextHelper.smallTextStyle.copyWith(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .03),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: remove,
                          splashFactory: NoSplash.splashFactory,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          child: Container(
                            width: double.infinity,
                            height: height * .06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: ColorConstants.colorPrimary.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(height * .06),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Remove',
                              style: (Device.width >= 1024)
                                  ? TextHelper.extraSmallTextStyle.copyWith(fontWeight: FontWeight.w600, color: ColorConstants.colorPrimary, fontSize: 12.sp)
                                  : TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorPrimary, fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          onTap: move,
                          splashFactory: NoSplash.splashFactory,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          child: Container(
                            width: double.infinity,
                            height: height * .06,
                            decoration: BoxDecoration(
                              color: ColorConstants.colorPrimary,
                              border: Border.all(
                                color: ColorConstants.colorPrimary.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(height * .06),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.favorite_border_rounded,
                                  color: Colors.white,
                                  size: 17,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Move to Wishlist',
                                  style: (Device.width >= 1024)
                                      ? TextHelper.extraSmallTextStyle.copyWith(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 12.sp)
                                      : TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .02),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Remove product from cart?',
                  style: (Device.width >= 1024) ? TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500) : TextHelper.subTitleStyle,
                ),
                SizedBox(height: height * .02),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: (Device.width >= 1024) ? (width * .05) : width * .3,
                      height: (Device.width >= 1024) ? width * .07 : width * .35,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: CustomNetworkImage(
                        imageUrl: product.image,
                        width: (Device.width >= 1024) ? (width * .05) : width * .3,
                        height: (Device.width >= 1024) ? width * .07 : width * .35,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'You can save this product to your wishlist instead, and find it with ease the next time you come back.',
                          maxLines: 1000,
                          style: (Device.width >= 1024) ? TextHelper.smallTextStyle.copyWith() : TextHelper.smallTextStyle.copyWith(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .02),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: remove,
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        child: Container(
                          width: double.infinity,
                          height: height * .06,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: ColorConstants.colorPrimary.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(height * .06),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Remove',
                            style: (Device.width >= 1024)
                                ? TextHelper.extraSmallTextStyle.copyWith(fontWeight: FontWeight.w600, color: ColorConstants.colorPrimary)
                                : TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorPrimary),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: move,
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        child: Container(
                          width: double.infinity,
                          height: height * .06,
                          decoration: BoxDecoration(
                            color: ColorConstants.colorPrimary,
                            border: Border.all(
                              color: ColorConstants.colorPrimary.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(height * .06),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.white,
                                size: 17,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Move to Wishlist',
                                style: (Device.width >= 1024)
                                    ? TextHelper.extraSmallTextStyle.copyWith(fontWeight: FontWeight.w600, color: Colors.white)
                                    : TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .02),
              ],
            ),
          );
  }
}
