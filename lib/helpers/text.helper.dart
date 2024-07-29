// /*
//  * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
//  */

import 'package:fabpiks_web/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextHelper {
  static TextStyle largeFontStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: (kIsWeb && Device.width < 1024) ? 32.sp : 30.sp,
    fontFamily: 'Montserrat',
    overflow: TextOverflow.ellipsis,
    color: ColorConstants.colorBlack,
    decoration: TextDecoration.none,
  );

  static TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: (kIsWeb && Device.width < 1024) ? 20.sp : 18.sp,
    fontFamily: 'Montserrat',
    overflow: TextOverflow.ellipsis,
    color: ColorConstants.colorBlack,
    decoration: TextDecoration.none,
  );
  static TextStyle subTitleStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: (kIsWeb && Device.width < 1024) ? 18.sp : 16.sp,
    fontFamily: 'Montserrat',
    overflow: TextOverflow.ellipsis,
    color: ColorConstants.colorBlack,
    decoration: TextDecoration.none,
  );
  static TextStyle normalTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: (kIsWeb && Device.width < 1024) ? 16.sp : 14.sp,
    fontFamily: 'Montserrat',
    overflow: TextOverflow.ellipsis,
    color: ColorConstants.colorBlack,
    decoration: TextDecoration.none,
  );
  static TextStyle smallTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: (kIsWeb && Device.width < 1024) ? 14.sp : 12.sp,
    fontFamily: 'Montserrat',
    overflow: TextOverflow.ellipsis,
    color: ColorConstants.colorBlack,
    decoration: TextDecoration.none,
  );
  static TextStyle extraSmallTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: (kIsWeb && Device.width < 1024) ? 12.sp : 10.sp,
    fontFamily: 'Montserrat',
    overflow: TextOverflow.ellipsis,
    color: ColorConstants.colorBlack,
    decoration: TextDecoration.none,
  );

// web fonts
// static TextStyle smallTextStyleWeb = TextStyle(
//   fontWeight: FontWeight.w400,
//   fontSize: ResponsiveScreenUtil().setSp(12),
//   fontFamily: 'Montserrat',
//   color: colorBlack,
//   decoration: TextDecoration.none,
// );
// static TextStyle extraSmallTextStyleWeb = TextStyle(
//   fontWeight: FontWeight.w400,
//   fontSize: ResponsiveScreenUtil().Setsp(10),
//   fontFamily: 'Montserrat',
//   overflow: TextOverflow.ellipsis,
//   color: colorBlack,
//   decoration: TextDecoration.none,
// );
}
