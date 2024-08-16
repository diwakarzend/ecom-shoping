/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDialog extends StatelessWidget {
  final Function() onTap;
  final Function()? onClose;
  final Function()? on2ndButtonClicked;
  final String icon;
  final String buttonName;
  final String buttonName2;
  final String message;
  final String title;
  final bool haveButtons;
  final bool have2ndButton;

  const CustomDialog({
    super.key,
    required this.onTap,
    required this.icon,
    required this.buttonName,
    required this.title,
    required this.message,
    required this.haveButtons,
    this.onClose,
    this.have2ndButton = false,
    this.buttonName2 = '',
    this.on2ndButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.transparent,
      content: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            width: (Device.width >= 1024) ? width * .25 : width,
            // constraints: BoxConstraints(
            //   minHeight: height * .55,
            //   maxHeight: height * .7,
            // ),
            decoration: BoxDecoration(
              color: ColorConstants.colorAlertBG,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: (Device.width >= 1024) ? 20 : width * .05, vertical: (Device.width >= 1024) ? 20 : width * .05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * .11),
                if (title.isNotEmpty)
                  Text.rich(
                    maxLines: 1000,
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: title,
                      style: (Device.width < 1024)
                          ? TextHelper.normalTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                              color: ColorConstants.colorBlack,
                              // height: 1.2,
                            )
                          : TextHelper.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                              color: ColorConstants.colorBlack,
                              fontSize: 14.sp,
                              // height: 1.2,
                            ),
                    ),
                  ),
                Text.rich(
                  maxLines: 1000,
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: '\n$message',
                    style: (Device.width < 1024)
                        ? TextHelper.normalTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.colorBlack,
                            height: 1.3,
                            decoration: TextDecoration.none,
                          )
                        : TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.colorBlack,
                            height: 1.3,
                            fontSize: 14.sp,
                            decoration: TextDecoration.none,
                          ),
                  ),
                ),
                SizedBox(height: height * .05 - 20),
                if (haveButtons && buttonName.isNotEmpty)
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      width: (Device.width < 1024) ? width * .5 : width * .15,
                      height: height * .05,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: ColorConstants.colorBlueEight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        buttonName,
                        style: (Device.width < 1024)
                            ? TextHelper.normalTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                              )
                            : TextHelper.normalTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                                fontSize: 12.sp,
                              ),
                      ),
                    ),
                  ),
                if (have2ndButton && buttonName2.isNotEmpty)
                  GestureDetector(
                    onTap: on2ndButtonClicked,
                    child: Container(
                      width: (Device.width < 1024) ? width * .5 : width * .15,
                      height: height * .045,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: ColorConstants.colorBlueEight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        buttonName2,
                        style: (Device.width < 1024)
                            ? TextHelper.normalTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                              )
                            : TextHelper.smallTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                                fontSize: 12.sp,
                              ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              transform: Matrix4.translationValues(0, -width * .04, 0),
              width: width * .09,
              height: width * .09,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.colorLogin.withOpacity(0.2),
              ),
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.colorLogin.withOpacity(0.2),
                ),
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.colorLogin.withOpacity(0.2),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.colorBlueEight.withOpacity(1),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      icon,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                if (onClose != null) {
                  onClose!();
                } else {
                  context.router.maybePop();
                }
              },
              child: Container(
                width: 40,
                height: 40,
                transform: Matrix4.translationValues(5, -8, 0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.colorOffWhite,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.clear_rounded,
                  color: ColorConstants.colorBlack,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
