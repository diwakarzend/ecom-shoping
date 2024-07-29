/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SurveyPopup extends StatelessWidget {
  final String message;

  const SurveyPopup({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
      ),
      child: Container(
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: Colors.transparent,
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.black.withOpacity(0.5),
                    size: 25,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * .02),
            Icon(
              Icons.check_circle_rounded,
              size: height * .07,
              color: ColorConstants.colorGreenTwo,
            ),
            SizedBox(height: height * .02),
            Text(
              'Thank You!',
              style: TextStyle(
                fontSize: 24.sp,
                color: ColorConstants.colorPrimaryTwo,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: height * .01),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                color: ColorConstants.colorGreyTwentyOne,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: height * .02),
            InkWell(
              onTap: () => Navigator.pop(context),
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              child: Container(
                width: width * .3,
                height: height * .05,
                decoration: BoxDecoration(
                  color: ColorConstants.colorPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Okay,done!',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorConstants.colorPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
